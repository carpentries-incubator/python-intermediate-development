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
- Understand the use of type annotations in libraries like `pydantic`, `cattrs` or `msgspec`.

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
- Automatic serialization.

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

Change the function signature to:

```python
def logistic_map(r: float, x: float) -> float:
  return r * x * (1 - x)
```

Do you see any effect in on the erronous call in your editor?
:::

### Abstract types

We don't always care about the precise type of an object. For instance, if we just want to write a for loop over an iterable, and sometimes we want to express that `Any` object will do:

```python
from typing import Any
from collections.abc import Iterable

def print_numbered_list(items: Iterable[Any]):
    for i, v in enumerate(items):
        print(i, v)
```

There are many abstract types available in `collections.abc`.

### Completion

Write a function that changes all commas to semi-colons. Start by entering the following:

```python
def semicolonize(s: str) -> str:
  return s
```

Type a `.` after the `s`. Can you see the completion?

## Data classes

::: info
### Data before classes
In many languages structures or records are considered more primitive than classes, not so in Python. We will learn more about classes and their place in software design in part 3. In this section we'll only consider data classes as a means of grouping data.
:::

Type annotations go really well together with data classes, a means of combining elements into a larger data structure. Python supports creating classes using type annotation like so:

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

Now you don't need to define an `__init__` method. There are nice packages that use this technique to allow automatic serialisation and deserialisation. Check out the [`msgspec` package](https://jcristharif.com/msgspec/index.html).

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

::: challenge
### Serialization

Install `msgspec` and try writing and reading back an `Address` object to JSON. Can you think of the advantages of using this approach over Python native `json.dump`?

:::: solution
- less code
- automatic validation
- user friendly error reporting
- high performance
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

