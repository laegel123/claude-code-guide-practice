# Pipeline

간단한 수학 연산 파이프라인 모듈입니다.

## 함수 목록

### `add`

```python
def add(a: int | float, b: int | float) -> int | float
```

두 수를 더합니다.

**사용 예시**

```python
from ex_pipeline import add

result = add(3, 4)    # 7
result = add(1.5, 2)  # 3.5
```

---

### `divide`

```python
def divide(a: int | float, b: int | float) -> float
```

`a`를 `b`로 나눈 결과를 반환합니다.

- `b`가 `0`이면 `ValueError`를 발생시킵니다.
- `a` 또는 `b`가 `NaN`이면 `ValueError`를 발생시킵니다.

**사용 예시**

```python
from ex_pipeline import divide

result = divide(10, 4)   # 2.5
result = divide(7, 2)    # 3.5

# 예외 처리
try:
    divide(5, 0)
except ValueError as e:
    print(e)  # division by zero

import math
try:
    divide(math.nan, 3)
except ValueError as e:
    print(e)  # Arguments must not be NaN (got a=nan, b=3)
```
