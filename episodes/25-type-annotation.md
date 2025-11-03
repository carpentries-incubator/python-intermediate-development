---
title: 2.5 Type annotations
teaching: 15
exercises: 45
---

::::::::::::::::::::::::::::::::::::::: objectives

- Understand the advantages of type annotations
- List the most important type checkers
- Apply type annotations to simple functions
- Read parametric types like `list[int]` or `set[str]`
- Use type unions to introduce flexibility
- Design data classes using type annotations
- Understand the complexities of going all-out on types

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- What are type annotations?
- Why are types needed? Our scripts run fine without them!

::::::::::::::::::::::::::::::::::::::::::::::::::

## Why?

- Check your code for correctness before you run it.
- Force you to handle edge cases.
- Have documentation that is always correct.
- Better autocompletion.

## Tools

There are many type checkers available:

MyPy
: The OG, developed by none other than Guido van Rossum himself.

PyRight
: Often more feature rich than MyPy, developed by Microsoft as part of the Python language server.

Ty
: By Astral. Not yet feature complete, however Astral brought us `ruff` and `uv`, both stellar tools. So this could become the type checker of the future.

::: info
Tip: try several of these on some of the examples below. Which type checker has the nicest error messages? Did it find all of the bugs?
:::

::: challenge
### Exercise: type errors

Can you spot the mistake in the following code?

```python
def logistic_map(r, x):
  return r * x * (1 - x)

logistic_map("hello", 2.4)
```

What does the error message say went wrong? Do you think this is a good message?

:::: solution
The error says we can't multiply sequences with a non-int of type float and points to the sub-expression `r * x`. However, the mistake is made at the call point by entering a `str` argument in the first place.
::::

How about the following code?

```python
def binary_search(lst, value):
    low = 0
    high = len(lst)-1
    while low <= high: 
        mid = (low+high) / 2
        if lst[mid] > value:
          high = mid-1
        elif lst[mid] < value:
          low = mid+1
        else:
          return mid
    return -1

binary_search([3.4, 7.8, 9.1], 5.2)
```

Run a type-checker on the binary search example. What does it say?

:::: solution
We can't index `lst` with a floating point value. The mistake is at the division by 2, we should have used the `//` operator.
::::

Add type annotation to these codes:

```python
def logistic_map(r: float, x: float) -> float:
  return r * x * (1 - x)
```

Do we get nicer messages now? How about our binary search? We're not restricted to typing function arguments (although that's the most common use). By explicitly typing intermediate values, we may catch errors early.

```python
def binary_search(lst: list, value) -> int:
  low: int = 0
  high: int = len(lst)-1
  while low <= high: 
    mid: int = (low+high) / 2
    if lst[mid] > value:
      high = mid-1
    elif lst[mid] < value:
      low = mid+1
    else:
      return mid
  return -1
```

Is the problem now identified with `mypy`? Note that we haven't typed `value` yet: we'll get to that later.

:::: solution
In the `logistic_map` example we find that type hinting the arguments helps us identify that the caller made a mistake.
Only by specifying that we expect `mid` to be an integer, is the true culprit revealed.
::::

:::

## Union types

Sometimes we don't know the exact type of a value, or we'd lik to specify that a function can handle multiple different types. This is where type unions come in. For example, in the binary search, it is nicer to return `None` when we don't find an item. We can use the `|` operator to create a **type union**.

```python
def binary_search(lst: list, value) -> int | None:
  low: int = 0
  high: int = len(lst)-1
  while low <= high: 
    mid: int = (low+high) // 2
    if lst[mid] > value:
      high = mid-1
    elif lst[mid] < value:
      low = mid+1
    else:
      return mid
  return None
```

We don't always care about the precise type of an object. For instance, if we just want to write a for loop over an iterable, and sometimes we want to express that `Any` object will do:

```python
from typing import Any
from collections.abc import Iterable

def print_numbered_list(items: Iterable[Any]):
    for i, v in enumerate(items):
        print(i, v)
```

## Data classes

::: info
### Data before classes
In many languages structures or records are considered more primitive than classes, not so in Python. We will learn more about classes and their place in software design in part 3. In this section we'll only consider data classes as a means of grouping data.
:::

Type annotations go really well together with data classes, a means of combining elements into a larger data structure.

```python
from dataclasses import dataclass

@dataclass
class Address:
    street: str
    number: int
    suffix: str | None = None

address = Address("Science Park", 402, "Matrix THREE")

print(f"{address.street} {address.number}")
```

::: challenge
### Autocompletion

Write a function that prints an address. How is your IDE behaving with and without type annotation?

```python
def print_address(a: Address):
    ...
```

:::: solution
When you use type-annotation, you'll have better auto-completion.
::::
:::

## Optional: Generics and protocols

How would we type a function that returns the first element in a list? Suppose that we know that the list contains integers. Then:

```python
def first(lst: list[int]) -> int:
  ...
```

But we like to be more generic than that: hence generic types.

```python
def first[T](lst: list[T]) -> T:
  return lst[0]

first(["a", "b", "c"])
```

::: challenge
Try running `first([])`, does the type checker complain? Write a version of `first` that returns `None` on an empty list. What should the type signature be?

:::: solution
Use `Optional[T]` or `T | None`.

```python
def first[T](lst: list[T]) -> T | None:
  if not lst:
    return None
  return lst[0]
```
::::
:::


## Optional: Complete the `binary_search` example

We still haven't typed our `binary_search` algorithm completely. We'd like to express the fact that we can only search a list for values of the same type that it contains! We can introduce a type-variable as follows:

```python
def binary_search[T](lst: list[T], value: T) -> int | None:
  ...
```

This reads as: `binary_search` introduces an unknown type `T`, such that we expect `list[T]` and `T` to be the types of the arguments to this function.

::: challenge
Change your `binary_search` function with the above type definition. What does `mypy` say?

:::: solution
We haven't taught the type checker that our type should be able to handle comparison operations. When a type defines comparison like that, we say that the type is **ordered**.
::::
:::

There is no built-in type constraint for ordered types, we'll have to define our own.

```python
from typing import Protocol, Self

class Ord(Protocol):
  def __lt__(self: Self, other: Self) -> bool:
    ...
```

The full type definition of `binary_search`:

```python
def binary_search[T: Ord](lst: list[T], value: T) -> int | None:
  low: int = 0
  high: int = len(lst)-1
  while low <= high:
    mid: int = (low+high) // 2
    if lst[mid] > value:
      high = mid-1
    elif lst[mid] < value:
      low = mid+1
    else:
      return mid
  return -1
```

::: challenge
Try to call `binary_search` in ways that still make the type checker fail. Can you think of properties that we can't express in the type system?

:::: solution
It is surprisingly hard to find a type in Python that doesn't support the `<` operator. Sometimes this operator doesn't quite capture the meaning of orderedness. In the case of a `set`, the `<` operator checks that one is a subset of the other (a partial but not total order). Types that don't have comparison: `dict`, `complex`.

Even when all the types are satisfied, there's no way that the type system can check that our input list is actually sorted. We'd have to subtype `list` and ensure that on each mutation the list remains sorted; not impossible, but at this point most of us should agree that we're taking this silly example a bit too far.
::::
:::

## For the curious: Algebraic data types

Now that we know about type unions and type products (tuples, named tuples, or data classes), we have all the ingredients to write [algebraic data types](https://en.wikipedia.org/wiki/Algebraic_data_type). For instance, we can define a linked list:

```python
type List[T] = tuple[T, List[T]] | None

def make_list[T](*args: T) -> List[T]:
    match args:
        case (first, *rest):
            return (first, make_list(*rest))
        case _:
            return None

def list_to_str[T](lst: List[T]):
    match lst:
        case None:
            return "None"
        case (a, rest):
            return str(a) + " : " + list_to_str(rest)

l: List[int] = make_list(1, 2, 3)
print(l)
print(list_to_str(l))
```

The linked list may seem a bit silly, but we can also define tree structures and use `match/case` to traverse a tree. Data structures can become highly complex, but the type system helps us writing correct code here.

