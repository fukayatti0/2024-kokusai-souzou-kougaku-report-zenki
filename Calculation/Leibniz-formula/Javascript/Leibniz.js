// ライプニッツ公式計算
const calculateLeibnizFormula = (n) => {
    let piApprox = 0;
    let sign = 1;
    for (let i = 0; i < n; i++) {
        piApprox += sign / (2 * i + 1);
        sign = -sign;
    }
    piApprox *= 4;
    return piApprox;
}

// 計算する項数(1億)
const n = 100000000;

// ライプニッツ公式計算
piApprox = calculateLeibnizFormula(n);

// 誤差
calculationError = Math.abs(Math.PI - piApprox);

console.log(`円周率近似値  : ${piApprox}`);
console.log(`計算誤差      : ${calculationError}`);