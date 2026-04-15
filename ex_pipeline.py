from __future__ import annotations

import math


def add(a: int | float, b: int | float) -> int | float:
    return a + b


def divide(a: int | float, b: int | float) -> float:
    if math.isnan(a) or math.isnan(b):
        raise ValueError(f"Arguments must not be NaN (got a={a}, b={b})")
    if b == 0:
        raise ValueError("division by zero")
    return a / b
