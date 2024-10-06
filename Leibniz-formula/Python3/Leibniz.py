import math

# ライプニッツ公式計算
def calculate_leibniz_formula(n):
    pi_approx = 0
    sign = 1
    for i in range(n):
        pi_approx += sign / (2 * i + 1)
        sign = -sign
    pi_approx *= 4
    return pi_approx


# 計算する項数(1億回)
n = 100000000

# ライプニッツ公式計算
pi_approx = calculate_leibniz_formula(n)

# 誤差
calculation_error = math.pi - pi_approx

print("円周率近似値  : ", pi_approx)
print("計算誤差      : ", calculation_error)