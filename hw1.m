%AJ Imholte
%Empirical Finance
%Project 1


%1 
% evenNumbers = transpose(32:2:74);

%2
% x = [2 5 1 6];
%add 16 to each element:
% x = x + 16;
%add 3 to the odd elements
% x(1) = x(1) + 3;
% x(3) = x(3) + 3;
%compute the square root of each element
% x = sqrt(x);
%compute the square of each element
% x = x.^2;

%3
% x = [3 2 6 8]';
% y = [4 1 3 5]';

%Add the sum of the elements in x to y
% y(5) = sum(x);

%Raise each element of x to the power specified by corresponding element in
%y

x = [3 2 6 8]';
y = [4 1 3 5]';

%x = x.^y;
y = y./x;
% z = x.*y;
% w = sum(z);

%The result of x'*y - w is zero. This computation is the difference of the
%matrix product of the horizontally-transposed x matrix and the vertical
%y matrix by the sum of the element-by-element multiplication of the
%original x and y matrices.

%4
%   a. 2 / 2 * 3 should evalaute to 3.
%   b. The result should be 53.6
%   c. The result should be 6.
%   d. The result should be 2.25.
%   e. The result should be 81.
%   f. The result should be 2.5.
%   g. The result should be 2.
%   h. The result should be 2.5.

%5

% x = zeros(100, 1);
% for i = 1:length(x)
%     x(i) = -1.^(i + 1) / (2  * i - 1);
% end
% sum(x) %The sum of the vector x is -3.2843.

%Basic array syntax and manipulations

%1
% x = [3 1 5 7 9 2 6];
%   a. x(3) returns the third element of x, in this case 5.
%   b. x(1:7) returns the first through seventh elements, which is the
%   entire arrary in this case.
%   c. x(1:end) returns all the values of the array from 1 unitl the end of
%   the array. In this example, this returns the same values as x(1:7).
%   d. x(1:end-1) returns the all the values of the arrary other than the
%   last one. In this case, it returns the sequence 3, 1, 5, 7, 9, 2.
%   e. x(6:-2:1) yields a specific set of the values within the array x.
%   Specifically, the values that are returned start from the sixth element
%   of the array x and ends at the first element of x, taken steps of -2
%   between each value to be returned. So, this command returns the sixth,
%   fourth, and second elements of the array x, which are 2, 7, and 1
%   respectively.
%   f. The command x([1 6 2 1 1]) returns an array of values associated
%   with the first, sixth, second, first, and first element of the array x
%   respectively. In this example, this yields the sequence of  numbers 3,
%   2, 1, 3, 3.
%   g. sum(x) sums all the elements of x, which is 33 in this case.

%3

% x = [1 4 8];
% y = [2 1 5];
% A = [3 1 6; 5 2 7];

%a. The command x + y will run. It will show the sum of each corresponding
%element of x and y, which is the sequence 3, 5, 13.
%b. The command x + A will run. This will add the each element of x to
%corresponding elements of A. This provides the 2x3 matrix [4 5 14; 6 6
%16].
%c. x' + y will run. This results in the 3x3 matrix [3 2 6; 6 5 9; 10 9
%13].
%d. A - [x' y'] will not run. This is because the matrix dimensions do not
%match.
%e. The command [x ; y'] will not run because the dimensions of x and y'
%do not match. 
%f. The command [x ; y] will run. This will result in the 2x3 matrix [1 4
%8; 2 1 5].
%g. The command A - 3 will run. The scalar 3 is subtrated from each element
%of A, resulting in the 2x3 matrix [0 -2 3; 2 -1 4].

%4.
% A = [2 7 9 7; 3 1 5 6; 8 1 2 5];
%   a. A' results in the transposed version of the original matrix A. This
%   results in a 3x4 matrix: [2 3 8; 7 1 1; 9 5 2; 7 6 5]
%   b. The command A(:,[1 4]) results in all the values of the first and
%   fourth column of the matrix A, which is a 3x2 matrix: [2 7; 3 6; 8 5]
%   c. The command A([2 3], [3 1]) returns the values corresponding to the
%   second and third rows and third and first columns of matrix A. This
%   returns the 2x2 matrix [5 3; 2 8].
%   d. This command reshapes the original A matrix (3x4) to a (2x6) matrix:
%   [2 8 1 9 2 6; 3 7 1 5 7 5].
%   A(:) returns the value of all the rows and columns from matrix A in a
%   12x1 array.
%   f. The command flipud(A) flips the values of the matrix so the last row
%   is now the first row and the first row is now the last row. The middle
%   row remains the same as before.
%   g. This command makes the two colums to the right (3 and 4) columns 1
%   and 2 and the two columns on the left (originally 1 and 2) columns 3
%   and 4.
%   h. The command [A A(end,:)] will not run because the A and A(end,:) do
%   not have the same dimensions.
%   i. The command A(1:3,:) results in first three rows of the matrix and A
%   and all the columns. So, this gives us the original matrix A
%   back.
%   j. The command [A ; A(1:2,:)] results in a 5x4 matrix that is the
%   original matrix A, with two additional rows added. These two additional
%   rows are the first and second rows from the original matrix.
%   k. sum(A) returns the sums of each of the four columns of the matrix A:
%   13, 9, 16, and 18.
%   l. sum(A') returns the sume of each of the three columns of the
%   transposed A matrix: 25, 15, and 16.
%   m. sum(A, 2) returns the sums of the three colums of matrix A: 25, 15,
%   16.
%   k. This command gives us the original matrix with the row sums in the
%   last column and the column somes in the last row.

%5.
% B = [A(: , [2 4])];
% C = [A([1 3] , :)];
% A = reshape(A, 4, 3);
% A./(A.^2);
% sqrt(A);

%6.
% randn('seed',123456789);
% F = rand(5, 10);
% avg = mean(F);
% s = std(F);

%Relational and logical operations
% x = [1 5 2 8 9 0 1];
% y = [5 2 2 6 0 0 2];
%a. The command x > y returns a logical array that tells us which elements
%of x are greater than its corresponding element in y.
%b. The command y < x returns the logical array that tells us which
%elements of y are less than its corresponding element in x.
%c. The command x == y returns the logical array that tells us which
%elements of y and x are equivalent.
%d. The command x <= y returns a logical array that tells us which elements
%of x are less than or equal to its corresponding element in y.
%e. The command >= x returns a logical array that tells us which elements
%of y are greater or equal to its corresponding element in x.
%f. The command x | y returns a logical array that tells us if the
%logical statement "x or y" is true or false for each element of x and y.
%g. The command x & y returns a logical array that tells us if the logical
%statement "x and y" for each element is true or false.
%h. The command x & (~y) returns a logical array that tells us if the
%logical statement "x and not y" is true or false.
%i. This command returns a logical array that tells us if the logical
%statement "x is greater than why or y is less than x" is true or false for
%each element of x and y.
%j. This command returns a logical array that tells us whether the logical
%statement "x is greater than y and y is less than x" is true or false for
%each element of x and y. 

%2
x = 1:10;
y = [3 1 5 6 8 2 9 4 7 0];
%a. This command results in a logical array that tell us which elements of
%x are greater than 3 and less than 8.
%b. The command x(x > 5) gives us the elements of x that are greater than
%5.
%c. The command y(x <= 4) returns the corresponding elements of y where the
%condition "x is less than or equal to 4" is true for the elements of x.
%d. The command x( (x < 2) | (x >= 8) ) returns the elements of x where x
%is less than two or x is greater than or equal to 8.
%e. This command gives the values of y corresponding to the indices of x
%where x is less than 2 or greater than or equal to 8.
%f. This command returns the values of x corresponding to the indices of y
%where x is less than 0.

%3.
% x = [3 15 9 12 -1 0 -12 9 6 1];
%Make positive numbers zero

% for i = 1:length(x)
%     if(x(i) > 0)
%         x(i) = 0;
%     end
% end

%Set the numbers that are multiples of three equal to three

% for i = 1:length(x)
%     if(mod(x(i), 3) == 0)
%         x(i) = 3;
%     end
% end

%Multiple the values of x that are even by 5

% for i = 1:length(x)
%     if(mod(x(i), 2) == 0)
%         x(i) = 5 * x(i);
%     end
% end

%Extract the values of x that are greater than 10 into a vector called y

% y = [];
% for i = 1:length(x)
%     if(x(i) > 10)
%         y = [y x(i)];
%     end
% end

%Set the values of x that are less than the mean of x to zero

% for i = 1:length(x)
%     if(x(i) < mean(x))
%         x(i) = 0;
%     end
% end

%Set the values of x that are greater than the mean of x to their
%difference from the mean

% for i = 1:length(x)
%     if(x(i) > mean(x))
%         x(i) = x(i) - mean(x);
%     end
% end

%If-blocks
% 1.   if n > 1            a. n = 7   m = ?
%         m = n+1          b. n = 0   m = ?
%      else                c. n = -10 m = ?
%         m = n - 1
%      end
% 
% a.	M is equal to 8.
% b.	M is equal to -1.
% c.	M is equal to -11.
%   
%      
% 2.   if z < 5            a. z = 1    w = ?
%         w = 2*z          b. z = 9    w = ?
%      elseif z < 10       c. z = 60   w = ?
%         w = 9 - z        d. z = 200  w = ?
%      elseif z < 100
%         w = sqrt(z)
%      else
%         w = z
%      end
% 
% a.	W is equal to 2.
% b.	W is equal to 0.
% c.	W is equal to 7.746.
% d.	W is equal to 200.
% 
%      
% 3.   if T < 30           a. T = 50    h = ?
%         h = 2*T + 1      b. T = 15    h = ?
%      elseif T < 10       c. T = 0     h = ?
%         h = T - 2
%      else
%         h = 0
%      end
% 
% a.	H is equal to 0
% b.	H is equal to 31.
% c.	H is equal to 1.
% 
% 4.   if 0 < x < 10           a. x = -1   y = ?
%         y = 4*x              b. x = 5    y = ?
%      elseif 10 < x < 40      c. x = 30   y = ?
%         y = 10*x             d. x = 100  y = ?
%      else
%         y = 500
%      end
% a.	Y is equal to -4.
% b.	Y is equal to 20.
% c.	Y is equal to 300.
% d.	Y is equal to 500.



% T = input('enter a value: ');
% 
% if (0 <  T) && (T < 100)
%     h(T) = T - 10;
% elseif T > 100
%     h(T) = 0.45 * T + 900;
% end
% h(T)

% x = input('enter a value: ');
% 
% if x < 0
%     f = -1;
% elseif x == 0
%     f = 0;
% elseif x > 0
%     f = 1;
% end
% f;


% y = input('Enter a number: ')

% if y < 10000
%     t(y) = 200;
% elseif (10000 < y) && (y < 20000)
%     t(y) = 200 + 0.1 * (y - 10000);
% elseif (20000 < y) && (y < 50000)
%     t(y) = 1200 + 0.15 * (y - 20000);
% elseif y > 50000
%     t(y) = 5700 + 0.25 * (y - 50000);
% end
% 
% t(y)

%     if y < 10000
%        t = 200
%     elseif 10000 < y < 20000
%        t = 200 + 0.1*(y - 10000)
%     elseif 20000 < y < 50000
%        t = 1200 + 0.15*(y - 20000)
%     elseif y > 50000
%        t = 5700 + 0.25*(y - 50000)
%     end

% Because each t is not t(y), and logical statements area not properly coded,
% this causes the case where y = 25000 to fail, since it cannot get to the
% next logical elseif statement where t is correctly evaluated for y = 25000,
% which is t = 1200 + 0.15 * (y – 20000). This causes t to be incorrectly
% computed to 1700 instead of 1950.


% Loop commands

% x = [1 8 3 9 0 1];

% Sum = 0;
% for i = 1:length(x)
%     Sum = Sum + x(i);
% end
% 
% j = zeros(size(x));
% 
% for i = 1:length(x)
%     j(i) = sum(x(1:i));
% end

% mnarray = rand(3,2);
% for i = 1:size(mnarray, 2)
%     for j = 1:size(mnarray, 1)
%         if mnarray(j,i) < 0.2
%             mnarray(j,i) = 0;
%         elseif mnarray(j,i) >= 0.2
%             mnarray(j,i) = 1;
%         end
%     end
% end

x = [4 1 6];
y = [6 2 7];
a = [];
for i = 1:length(x)
    for j = 1:length(y)
        a(i, j) = x(i) * y(j);
    end
end

b = [];
for i = 1:length(x)
    for j = 1:length(y)
        b(i, j) = x(i) / y(j);
    end
end

c = [];
Sum = 0;
for i = 1:length(x)
    for j = 1:length(y)
        c(i, j) = x(i) * y(j);
        Sum = Sum + c(i, j);
    end
end

d = [];
for i = 1:length(x)
    for j = 1:length(y)
        d(i, j) = x(i) / (2 + x(i) + y(j));
    end
end

e = [];
for i = 1:length(x)
    for j = 1:length(y)
        if x(i) < y(j)
            e(i, j) = 1 / x(i);
        elseif y(j) < x(i)
            e(i, j) = 1 / y(j);
        end
    end
end

% count = 0;
% Sum = 0;
% while(Sum >= 0) && (Sum < 20)
%     Sum = Sum + rand(1);
%     count = count + 1;
% end
% count; %takes 36 times

% count = 0;
% number = rand(1);
% while(number < 0.8) || (number > 0.85)
%     count = count + 1;
%     number = rand(1);
% end
% count; %took 20 times

% numbers = [rand(1)];
% avg = mean(numbers);
% count = 1;
% while(avg < 0.01) || (avg > 0.5)
%     numbers = [numbers; rand(1)];
%     avg = mean(numbers);
%     count = count + 1;
% end
% count; %took 124 times


%Programming activites

%Fibonacci Numbers


%First 10 Fibonacci numbers
% fnumbers = [1 1 zeros(1,8)];
% for i = 3:length(fnumbers)
%     fnumbers(i) = fnumbers(i-1) + fnumbers(i-2);
% end

fnumbers = [1 1 zeros(1,48)];
ratio = [NaN 1];
for i = 3:length(fnumbers)
    fnumbers(i) = fnumbers(i-1) + fnumbers(i-2);
    ratio(i) = fnumbers(i) / fnumbers(i-1); 
end

%These results show that the ratio does approach the golden mean!

%Annuity

p = (50000 / 0.05) * (((1+0.05).^20 - 1) / (1 + 0.05).^20);
p > 500000; %p is greater than 500,000, so we should take the 50,000
%dollars per year for 20 years.




    






        












     
        


        


    






























