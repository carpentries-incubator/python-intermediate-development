---
title: "Mocking for Unit Testing"
teaching: 25
exercises: 20
questions:
- "How can we test components in isolation that depend on an external environment or 
  other components?"
objectives:
- "Describe how to use unittest.mock to replace either a remote call or a dependent 
  function"
- "Use mocking to add to the test suite for our inflammation example"
keypoints:
- "Mocking is useful for implementing unit tests that test each component in isolation."
- "Mocking can remove dependencies on external environment such as the internet, the 
  filesystem, or it can remove dependencies from other components"
- "Testing in isolation is essential as it gives you a test suite that can properly 
  identify where bugs are occuring"
---

Mocking is a testing term that means to replace a real object with a pretend object. One 
of the most common objections to unit testing is that it can be quite difficult to test 
each function or class method in isolation, because of the dependencies that exist in 
all but the simplest code. For example:

1. Your function/class might depend on a remote resource such as a website, FTP server 
   or a cloud-based API that you are calling
2. Function A, that you wish to tests, might use another function B as part of its work
3. The class you wish to test, class A, might contain an instance of another class B 
   that is difficult to construct (i.e. perhaps it depends on loading a large and 
   cumbersome dataset).

For example 1, you would like your tests to pass even if the computer in question has no 
internet. For example 2, ideally you would want to be able to write a test for function 
A that didn't depend on function B, so that if a bug occurred in function B, your tests 
for function A would still pass. For example 3, it would be nice to be able to test 
class A without having to construct the difficult-to-create object of class B.

For all these reasons, and many others, you can use mocking libraries to make your unit 
tests easier to write. There are many such libraries/frameworks that exist for different 
languages, for example:

- **C**: [CMocka](https://cmocka.org/)
- **C++**: [googletest](https://github.com/google/googletest)
- **Python**: [unittest.mock](https://docs.python.org/3/library/unittest.mock.html)

# Recording calls with mock

This lesson demonstrates the use of `unittest.mock`. This is a mocking framework within 
the Python3 standard library, and is therefore quite convenient to use. The 
documentation for `unittest.mock` is 
[here](https://docs.python.org/3/library/unittest.mock.html). This framework contains a 
class `Mock`, which is callable and records all the calls that are made to it. For 
example, below we create an object of class `Mock`, and tell it to return `2` on every 
function call.

~~~
from unittest.mock import Mock
function = Mock(name="myroutine", return_value=2)
function(1)
~~~
{: .language-python}

~~~
2
~~~
{: .output}

We can call our fake "function" with any number of arguments, with any type. However we 
call the function, it will always return the value `2`.

~~~
function(5, "hello", a=True)
~~~
{: .language-python}

~~~
2
~~~
{: .output}

We can interrogate the `Mock` object to allow us to see how it has been called, we can 
use this functionality in tests to assert that the mock object is being called 
correctly. The `mock_calls` attribute returns an array of calls made to `function`.

~~~
function.mock_calls
~~~
{: .language-python}

~~~
[call(1), call(5, 'hello', a=True)]
~~~
{: .output}

Each element of the returned array is a `call` object, which stores the arguments for 
each call. 

~~~
name, args, kwargs = function.mock_calls[1]
args, kwargs
~~~
{: .language-python}

~~~
((5, 'hello'), {'a': True})
~~~
{: .output}

Many real-world objects would contain some sort of state, which would change as the 
object is used via side-effects. `Mock` objects can also be setup to reproduce this 
behaviour like so:

~~~
function = Mock(name="myroutine", side_effect=[2, "xyz"])
function(1)
~~~
{: .language-python}

~~~
2
~~~
{: .output}

~~~
function(1, "hello", {'a': True})
~~~
{: .language-python}

~~~
'xyz'
~~~
{: .output}

Since we have only specified two side-effects for our mock object, we therefore expect 
an error if the function is called again:

~~~
function()
~~~
{: .language-python}

~~~
---------------------------------------------------------------------------
StopIteration                             Traceback (most recent call last)
<ipython-input-10-2fcbbbc1fe81> in <module>()
----> 1 function()

C:\ProgramData\Anaconda3\lib\unittest\mock.py in __call__(_mock_self, *args, **kwargs)
    917         # in the signature
    918         _mock_self._mock_check_sig(*args, **kwargs)
--> 919         return _mock_self._mock_call(*args, **kwargs)
    920 
    921 

C:\ProgramData\Anaconda3\lib\unittest\mock.py in _mock_call(_mock_self, *args, **kwargs)
    976 
    977             if not _callable(effect):
--> 978                 result = next(effect)
    979                 if _is_exception(result):
    980                     raise result

StopIteration: 
~~~
{: .output}

This demonstrates a couple of the features of `unittest.Mock` to give you a flavor of 
how it can be used to create a mock object. There are of course many other features of 
the library, for example the ability to create mock methods and attributes for your mock 
object. You can read more about these in the 
[documentation](https://docs.python.org/3/library/unittest.mock.html).

# Using mocks to model test resources

Often we want to write tests for code which interacts with remote resources. (e.g. 
databases, the internet, or data files)

We don't want to have our tests actually interact with the remote resource, as this 
would mean our tests failed due to lost internet connections, for example.

Instead, we can use mocks to assert that our code does the right thing in terms of the 
messages it sends: the parameters of the function calls it makes to the remote resource.

For example, consider the following code that downloads a map from the internet using 
the Google API:

~~~
import requests

def map_at(lat, long, satellite=False, zoom=12, 
           size=(400, 400), sensor=False):

    base = "http://maps.googleapis.com/maps/api/staticmap?"
    
    params = dict(
        sensor = str(sensor).lower(),
        zoom = zoom,
        size = "x".join(map(str,size)),
        center = ",".join(map(str,(lat,long))),
        style = "feature:all|element:labels|visibility:off")
    
    if satellite:
        params["maptype"] = "satellite"
        
    return requests.get(base, params=params)

london_map = map_at(51.5073509, -0.1277583)
from IPython.display import Image
~~~
{: .language-python}

We would like to write a test to check that the `map_at` function is building the 
parameters correctly for the call to the google mapping API. We can do this by mocking 
the requests object. Note that we could simply put a `print` statement in the function 
to verify this, but this would have to be removed, so writing a test for this is a more 
long-term and sustainable solution.

We need to temporarily replace a method, specifically the `requests.get()` function, with 
a mock. We can use `unittest.mock.patch` to do this:

~~~
from unittest.mock import patch
with patch.object(requests,'get') as mock_get:
    london_map = map_at(51.5073509, -0.1277583)
    print(mock_get.mock_calls)
~~~
{: .language-python}

The `patch.object` function replaces the named attribute (in this case `get`) in the 
named object (`requests`), with a mock object `mock_get`. In the same manner as we saw 
for the `Mock` objects, we can query `mock_get` to get the arguments that `requests.get` 
was called with.

~~~
[call('http://maps.googleapis.com/maps/api/staticmap?', params={'center': '51.5073509,-0.1277583', 'sensor': 'false', 'style': 'feature:all|element:labels|visibility:off', 'size': '400x400', 'zoom': 12})]
~~~
{: .output}

Our test for the `map_at` function then looks like:

~~~
def test_build_default_params():
    with patch.object(requests,'get') as mock_get:
        default_map = map_at(51.0, 0.0)
        mock_get.assert_called_with(
            "http://maps.googleapis.com/maps/api/staticmap?",
            params={
                'sensor':'false',
                'zoom':12,
                'size':'400x400',
                'center':'51.0,0.0',
                'style':'feature:all|element:labels|visibility:off'
            }
        )
~~~
{: .language-python}

`unittest.patch` can be used as a [function 
decorator](https://docs.python.org/3/library/unittest.mock.html#unittest.mock.patch) to 
replace an argument of the function with a mock, it can used to patch a [object 
attribute](https://docs.python.org/3/library/unittest.mock.html#unittest.mock.patch.object) 
, a 
[dictionary-like](https://docs.python.org/3/library/unittest.mock.html#unittest.mock.patch.dict) 
object, or to apply 
[multiple](https://docs.python.org/3/library/unittest.mock.html#unittest.mock.patch.multiple) 
patches as once. 

Here is the same test for `map_at`, now written using a `patch` function decorator.

~~~
@patch('requests.get')
def test_build_default_params(mock_get):
      default_map = map_at(51.0, 0.0)
      mock_get.assert_called_with(
        "http://maps.googleapis.com/maps/api/staticmap?",
        params={
            'sensor':'false',
            'zoom':12,
            'size':'400x400',
            'center':'51.0,0.0',
            'style':'feature:all|element:labels|visibility:off'
        }
      )
~~~
{: .language-python}

# Testing functions that call other functions

Often we wish to test a function in isolation from other, dependent functions, so that 
we can write independent tests. For example, we want to test that the below function 
does the right thing. It is supposed to compute the derivative of a function of a vector 
in a particular direction.

~~~
def partial_derivative(function, at, direction, delta=1.0):
    f_x = function(at)
    x_plus_delta = at[:]
    x_plus_delta[direction] += delta
    f_x_plus_delta = function(x_plus_delta)
    return (f_x_plus_delta - f_x) / delta
~~~
{: .language-python}

We can us the `partial_derivative` function to, for example, calculate the derivative of 
the `sum` function.

~~~
partial_derivative(sum, [0,0,0], 1)
~~~
{: .language-python}

~~~
1.0
~~~
{: .output}

How do we assert that it is doing the right thing? One way we could do this is to check 
the result of the function against the correct solution. After all, we know that the 
partial derivative of the `sum` function should be 1, we could also check the 
performance of the function using other test functions as well. But with mocks we can 
also write a test that is completely independent of the specific function we might use, 
and one that directly tests that the `partial_derivative` is doing what you expect it to 
do. Here is a possible test using a `Mock` to replace the input `function` argument. 

~~~
from unittest.mock import Mock

def test_derivative_2d_y_direction():
    func = Mock(return_value=0)
    partial_derivative(func, [0,0], 1)
    func.assert_any_call([0, 1.0])
    func.assert_any_call([0, 0])
    

test_derivative_2d_y_direction()
~~~
{: .language-python}


> ## Write a unit test for `load_csv` using mocks
>
> Go back to the `inflammation` example that we used in the previous lessons.
>
> Write a unit test for the `load_csv` function in `inflammation/models.py`. Use mocking 
> to remove the dependence on the `np.loadtxt` and `inflammation.models.get_data_dir` 
> functions. Make sure to test for the two different behaviours of the function which 
> occur when the input filename is either absolute or relative.
>
> Once you are finished, commit your changes and then merge all the new commits on your 
> `test-suite` branch into `master.
>
> > ## Solution
> > 
> > ~~~
> > ...
> >@patch('inflammation.models.get_data_dir', return_value='/data_dir')
> >def test_load_csv(mock_get_data_dir):
> >    from inflammation.models import load_csv
> >    with patch('numpy.loadtxt') as mock_loadtxt:
> >        load_csv('test.csv')
> >        name, args, kwargs = mock_loadtxt.mock_calls[0]
> >        assert kwargs['fname'] == '/data_dir/test.csv'
> >        load_csv('/test.csv')
> >        name, args, kwargs = mock_loadtxt.mock_calls[1]
> >        assert kwargs['fname'] == '/test.csv'
> > ...
> > ~~~
> > {: .language-python}
> {: .solution}
>
{: .challenge}



{% include links.md %}
