// Lab 3 - Ex 2.1 .. 2.6 : ve so do tin hieu roi rac (stem plot)
clear; clc;
ids = winsid();
if ids <> [] then
    close(ids);
end

function stem_plot(n, y, ttl)
    plot2d3(n, y);                 // cac duong tha thang dung
    plot(n, y, "ro");              // dau tron tai moi mau
    a = gca();
    a.data_bounds = [min(n)-0.5, min(min(y),0)-0.4; max(n)+0.5, max(max(y),0)+0.4];
    a.x_location = "origin";
    xgrid(color("lightgray"));
    title(ttl);
    xlabel("n");
endfunction

function y = ustep(n)             // u(n)
    y = bool2s(n >= 0);
endfunction

function y = dlt(n)               // delta(n)
    y = bool2s(n == 0);
endfunction

//2.1
function y = x21(n)
    y = zeros(n);
    i = (n >= -3) & (n <= -1);  y(i) = 1 + n(i)/3;
    j = (n >= 0)  & (n <= 3);   y(j) = 1;
endfunction

//P2.2 (doc tu hinh)
function y = x22(n)
    y = zeros(n);
    y((n >= -1) & (n <= 2)) = 1;
    y((n == 3) | (n == 4))  = 0.5;
endfunction

//2.1
n = -8:8;
scf(1); clf();
subplot(2,2,1); stem_plot(n, x21(n),     "2.1(a): x(n)");
subplot(2,2,2); stem_plot(n, x21(4-n),   "2.1(b)1: gap roi tre 4 = x(4-n)");
subplot(2,2,3); stem_plot(n, x21(-n-4),  "2.1(b)2: tre 4 roi gap = x(-n-4)");
subplot(2,2,4); stem_plot(n, x21(-n+4),  "2.1(c): x(-n+4)");

// (e) kiem tra bieu dien theo delta va u
xr = (1/3)*dlt(n+2) + (2/3)*dlt(n+1) + ustep(n) - ustep(n-4);
mprintf("2.1(e): sai so lon nhat giua x(n) va bieu dien delta/u = %g\n", max(abs(xr - x21(n))));

//2.2 (tin hieu hinh P2.2)
n = -8:8;
scf(2); clf();
stem_plot(n, x22(n), "Hinh P2.2: x(n)");

scf(3); clf();
subplot(4,2,1); stem_plot(n, x22(n-2),                  "2.2(a): x(n-2)");
subplot(4,2,2); stem_plot(n, x22(4-n),                  "2.2(b): x(4-n)");
subplot(4,2,3); stem_plot(n, x22(n+2),                  "2.2(c): x(n+2)");
subplot(4,2,4); stem_plot(n, x22(n).*ustep(2-n),        "2.2(d): x(n)u(2-n)");
subplot(4,2,5); stem_plot(n, x22(n-1).*dlt(n-3),        "2.2(e): x(n-1)delta(n-3)");
subplot(4,2,6); stem_plot(n, x22(n.^2),                 "2.2(f): x(n^2)");
xe = (x22(n) + x22(-n))/2;      // n doi xung quanh 0
xo = (x22(n) - x22(-n))/2;
subplot(4,2,7); stem_plot(n, xe, "2.2(g): phan chan x_e(n)");
subplot(4,2,8); stem_plot(n, xo, "2.2(h): phan le x_o(n)");

// 2.3 - kiem chung bang so
n = -10:10;
scf(4); clf();
subplot(2,2,1); stem_plot(n, dlt(n),                 "delta(n)");
subplot(2,2,2); stem_plot(n, ustep(n)-ustep(n-1),    "2.3(a): u(n)-u(n-1)");
subplot(2,2,3); stem_plot(n, cumsum(dlt(n)),         "2.3(b): tong_{k<=n} delta(k)");
subplot(2,2,4); stem_plot(n, ustep(n),               "u(n)");
mprintf("2.3(a): sai so = %g\n", max(abs(dlt(n) - (ustep(n)-ustep(n-1)))));
mprintf("2.3(b): sai so = %g\n", max(abs(cumsum(dlt(n)) - ustep(n))));
// tong thu hai: sum_{k=0}^{K} delta(n-k), lay K du lon (K = 10)
s2 = zeros(n);
for k = 0:10, s2 = s2 + dlt(n-k); end
mprintf("2.3(b) tong thu hai: sai so (n<=10) = %g\n", max(abs(s2 - ustep(n))));

//2.4
n = -2:2;
x  = [2 3 4 5 6];              // n=0 tai phan tu thu 3
xf = x($:-1:1);                // x(-n)
xe = (x + xf)/2;
xo = (x - xf)/2;
scf(5); clf();
subplot(3,1,1); stem_plot(n, x,  "2.4: x(n)");
subplot(3,1,2); stem_plot(n, xe, "2.4: phan chan x_e(n)");
subplot(3,1,3); stem_plot(n, xo, "2.4: phan le x_o(n)");
disp("2.4: xe = "); disp(xe); disp("xo = "); disp(xo);

//2.5 - kiem chung nang luong bang so (tin hieu 2.1)
n  = -10:10;
xx = x21(n);  xxe = (x21(n) + x21(-n))/2;  xxo = (x21(n) - x21(-n))/2;
mprintf("2.5: E = %g,  Ee + Eo = %g\n", sum(xx.^2), sum(xxe.^2) + sum(xxo.^2));

//2.6
function y = xb(n)              // x(n)=1 voi 0<=n<=3
    y = bool2s((n >= 0) & (n <= 3));
endfunction
function y = xb2(n)             // x2(n) = x(n-2)
    y = xb(n-2);
endfunction

function y = sysA(x, n)         // y(n) = x(n^2)
    y = x(n.^2);
endfunction
function y = sysB(x, n)         // y(n) = x(n) - x(n-1)
    y = x(n) - x(n-1);
endfunction
function y = sysC(x, n)         // y(n) = n x(n)
    y = n .* x(n);
endfunction

// ve 5 do thi (1)-(5) cho mot he thong; in ket luan (6)
function ve_he(sysf, ten, fig)
    n = -5:8;
    scf(fig); clf();
    y   = sysf(xb,  n);         // (2) y(n)
    yd  = sysf(xb,  n-2);       // (3) y(n-2)
    x2  = xb2(n);               // (4) x2(n)
    y2  = sysf(xb2, n);         // (5) y2(n)
    subplot(3,2,1); stem_plot(n, xb(n), ten + ": (1) x(n)");
    subplot(3,2,2); stem_plot(n, y,     "(2) y(n) = T[x(n)]");
    subplot(3,2,3); stem_plot(n, yd,    "(3) y(n-2)");
    subplot(3,2,4); stem_plot(n, x2,    "(4) x2(n) = x(n-2)");
    subplot(3,2,5); stem_plot(n, y2,    "(5) y2(n) = T[x2(n)]");
    if max(abs(y2 - yd)) < 1e-12 then
        mprintf("%s: y2(n) = y(n-2) voi tin hieu nay (chua du de ket luan bat bien theo thoi gian)\n", ten);
    else
        mprintf("%s: y2(n) <> y(n-2)  =>  he KHONG bat bien theo thoi gian\n", ten);
    end
endfunction

ve_he(sysA, "2.6(b) y=x(n^2)",        6);
ve_he(sysB, "2.6(c) y=x(n)-x(n-1)",   7);
ve_he(sysC, "2.6(d) y=n x(n)",        8);
