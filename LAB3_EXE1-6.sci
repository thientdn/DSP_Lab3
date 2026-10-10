clc;
clear;

//-------------------------------------------
//Exercise 1 delay function
function [yn, yorigin] = delay(xn, xorigin, k)
    // Check condition k > 0 as required
    if k <= 0 then
        error("Error: Value of k must be greater than 0!");
    end

    // Delay operation y(n) = x(n - k)
    yn = xn;
    yorigin = xorigin - k;
    
    // Generate time axis n for x(n) and y(n)
    nx = (1 - xorigin) : (length(xn) - xorigin); //[n_min : n_max]
    ny = (1 - yorigin) : (length(yn) - yorigin); //[y_min : y_max]
    
    // Plot figures in a new window
    scf(); // Create a new figure window for each call
    
    // Plot x(n) in blue (color = 2)
    plot2d3(nx, xn, 2); 
    plot(nx, xn, 'b.'); // Plot endpoints
    
    // Plot y(n) in red (color = 5)
    plot2d3(ny, yn, 5); 
    plot(ny, yn, 'r.'); // Plot endpoints
    
    // Plot configuration
    xtitle("Delay Operation: y(n) = x(n - " + string(k) + ")", "n (Time Index)", "Amplitude");
    legend(["x(n)"; "y(n) = x(n-" + string(k) + ")"]);
    xgrid(1); // Display grid
endfunction
//-------------------------------------------------------
// Testcase Exercise 1
mprintf("=== EXERCISE 1: DELAY ===\n");
[yn1, yorigin1] = delay([1, -2, 3, 6], 3, 1);
disp(yn1, "yn = ");
mprintf("yorigin = %d\n\n", yorigin1);
//-------------------------------------------------------
//Exercise 2 advance function
function [yn, yorigin] = advance(xn, xorigin, k)
    // Check condition k > 0 as required
    if k <= 0 then
        error("Error: Value of k must be greater than 0!");
    end

    // Advance operation y(n) = x(n + k)
    yn = xn;
    yorigin = xorigin + k;
    
    // Generate time axis n for x(n) and y(n)
    nx = (1 - xorigin) : (length(xn) - xorigin); //[n_min : n_max]
    ny = (1 - yorigin) : (length(yn) - yorigin); //[y_min : y_max]
    
    // Plot figures in a new window
    scf(); // Create a new figure window for each call
    
    // Plot x(n) in blue (color = 2)
    plot2d3(nx, xn, 2); 
    plot(nx, xn, 'b.'); // Plot endpoints
    
    // Plot y(n) in red (color = 5)
    plot2d3(ny, yn, 5); 
    plot(ny, yn, 'r.'); // Plot endpoints
    
    // Plot configuration
    xtitle("Advance Operation: y(n) = x(n + " + string(k) + ")", "n (Time Index)", "Amplitude");
    legend(["x(n)"; "y(n) = x(n+" + string(k) + ")"]);
    xgrid(1); // Display grid
endfunction

// Testcase Exercise 2
mprintf("=== EXERCISE 2: ADVANCE ===\n");
[yn2, yorigin2] = advance([1, -2, 3, 6], 3, 2);
disp(yn2, "yn = ");
mprintf("yorigin = %d\n", yorigin2);
//-------------------------------------------------------


//-------------------------------------------------------
// Exercise 3 Fold Function
function [yn, yorigin] = fold(xn, xorigin)
    // Folding operation y(n) = x(-n)
    yn = xn($:-1:1); // Reverse the vector xn
    yorigin = length(xn) - xorigin + 1;
    
    // Generate time axis n for x(n) and y(n)
    nx = (1 - xorigin) : (length(xn) - xorigin); //[n_min : n_max]
    ny = (1 - yorigin) : (length(yn) - yorigin); //[y_min : y_max]
    
    // 3. Plot figures in a new window
    scf(); // Create a new figure window for each call
    
    // Plot x(n) in blue (color = 2)
    plot2d3(nx, xn, 2); 
    plot(nx, xn, 'b.'); // Plot endpoints
    
    // Plot y(n) in red (color = 5)
    plot2d3(ny, yn, 5); 
    plot(ny, yn, 'r.'); // Plot endpoints
    
    // Plot configuration
    xtitle("Folding Operation: y(n) = x(-n)", "n (Time Index)", "Amplitude");
    legend(["x(n)"; "y(n) = x(-n)"]);
    xgrid(1); // Display grid
endfunction

// Testcase Exercise 3
mprintf("=== EXERCISE 3: FOLD ===\n");
[yn3, yorigin3] = fold([1, -2, 3, 6], 2);
disp(yn3, "yn = ");
mprintf("yorigin = %d\n", yorigin3);
//-------------------------------------------------------


//-------------------------------------------------------
// Exercise 4 Add Function
function [yn, yorigin] = add(x1n, x1origin, x2n, x2origin)
    // Determine time axes for both signals
    n1 = (1 - x1origin) : (length(x1n) - x1origin);
    n2 = (1 - x2origin) : (length(x2n) - x2origin);
    
    // Determine global time axis n
    n = min([min(n1), min(n2)]) : max([max(n1), max(n2)]);
    
    // Align signals using zero-padding
    y1 = zeros(1, length(n));
    y2 = zeros(1, length(n));
    
    y1(find(n >= min(n1) & n <= max(n1))) = x1n;
    y2(find(n >= min(n2) & n <= max(n2))) = x2n;
    
    // Perform addition y(n) = x1(n) + x2(n)
    yn = y1 + y2;
    yorigin = find(n == 0);
    
    // Plot x1(n), x2(n), and y(n) in a new window
    scf(); // Create a new figure window
    
    // Plot stems for all signals first (so legend matches correctly)
    plot2d3(n, y1, 2); // x1(n) stem in Blue (color = 2)
    plot2d3(n, y2, 3); // x2(n) stem in Green (color = 3)
    plot2d3(n, yn, 5); // y(n) stem in Red (color = 5)
    
    // Plot endpoints/markers for all signals
    plot(n, y1, 'b.'); // x1(n) markers in Blue
    plot(n, y2, 'g.'); // x2(n) markers in Green
    plot(n, yn, 'r.'); // y(n) markers in Red
    
    // Plot configuration
    xtitle("Addition Operation: y(n) = x1(n) + x2(n)", "n (Time Index)", "Amplitude");
    legend(["x1(n)"; "x2(n)"; "y(n) = x1(n) + x2(n)"]);
    xgrid(1); // Display grid
endfunction

// Testcase Exercise 4
mprintf("=== EXERCISE 4: ADD ===\n");
[yn4, yorigin4] = add([0, 1, 3, -2], 1, [1, 1, 2, 3], 2);
disp(yn4, "yn = ");
mprintf("yorigin = %d\n\n", yorigin4);
//-------------------------------------------------------


//-------------------------------------------------------
// Exercise 5 Multi Function
function [yn, yorigin] = multi(x1n, x1origin, x2n, x2origin)
    // Determine time axes for both signals
    n1 = (1 - x1origin) : (length(x1n) - x1origin);
    n2 = (1 - x2origin) : (length(x2n) - x2origin);
    
    // Determine global time axis n
    n = min([min(n1), min(n2)]) : max([max(n1), max(n2)]);
    
    // Align signals using zero-padding
    y1 = zeros(1, length(n));
    y2 = zeros(1, length(n));
    
    y1(find(n >= min(n1) & n <= max(n1))) = x1n;
    y2(find(n >= min(n2) & n <= max(n2))) = x2n;
    
    // Perform element-wise multiplication y(n) = x1(n) . x2(n)
    yn = y1 .* y2;
    yorigin = find(n == 0);
    
    // Plot x1(n), x2(n), and y(n) in a new window
    scf(); // Create a new figure window
    
    // Plot stems for all signals first (so legend matches correctly)
    plot2d3(n, y1, 2); // x1(n) stem in Blue (color = 2)
    plot2d3(n, y2, 3); // x2(n) stem in Green (color = 3)
    plot2d3(n, yn, 5); // y(n) stem in Red3G (color = 5)
    
    // Plot endpoints/markers for all signals
    plot(n, y1, 'b.'); // x1(n) markers in Blue
    plot(n, y2, 'g.'); // x2(n) markers in Green
    plot(n, yn, 'r.'); // y(n) markers in Red
    
    // Plot configuration
    xtitle("Multiplication Operation: y(n) = x1(n) . x2(n)", "n (Time Index)", "Amplitude");
    legend(["x1(n)"; "x2(n)"; "y(n) = x1(n) . x2(n)"]);
    xgrid(1); // Display grid
endfunction

// Testcase Exercise 5
mprintf("=== EXERCISE 5: MULTI ===\n");
[yn5, yorigin5] = multi([0, 1, 3, -2], 1, [1, 1, 2, 3], 2);
disp(yn5, "yn = ");
mprintf("yorigin = %d\n\n", yorigin5);
//-------------------------------------------------------


//-------------------------------------------------------
// Exercise 6 Convolution Function
function [yn, yorigin] = convolution(xn, xorigin, hn, horigin)
    // Perform discrete-time convolution y(n) = x(n) * h(n)
    yn = convol(xn, hn);
    
    // Calculate yorigin position
    yorigin = xorigin + horigin - 1;
    
    // Generate time axes for x(n), h(n), and y(n)
    nx = (1 - xorigin) : (length(xn) - xorigin);
    nh = (1 - horigin) : (length(hn) - horigin);
    ny = (1 - yorigin) : (length(yn) - yorigin);
    
    // Plot x(n), h(n), and y(n) in a new window
    scf(); // Create a new figure window
    
    // Plot stems for all signals first (for correct legend ordering)
    plot2d3(nx, xn, 2); // x(n) stem in Blue (color = 2)
    plot2d3(nh, hn, 3); // h(n) stem in Green (color = 3)
    plot2d3(ny, yn, 5); // y(n) stem in Red (color = 5)
    
    // Plot endpoints/markers for all signals
    plot(nx, xn, 'b.'); // x(n) markers in Blue
    plot(nh, hn, 'g.'); // h(n) markers in Green
    plot(ny, yn, 'r.'); // y(n) markers in Red
    
    // Plot configuration
    xtitle("Convolution Operation: y(n) = x(n) * h(n)", "n (Time Index)", "Amplitude");
    legend(["x(n)"; "h(n)"; "y(n) = x(n) * h(n)"]);
    xgrid(1); // Display grid
endfunction

// Testcase Exercise 6
mprintf("=== EXERCISE 6: CONVOLUTION ===\n");
[yn6, yorigin6] = convolution([1, 2, 3], 1, [1, 1], 1);
disp(yn6, "yn = ");
mprintf("yorigin = %d\n\n", yorigin6);
//-------------------------------------------------------
