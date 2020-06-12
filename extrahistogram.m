figure(23333)

subplot(2,4,1)
h0=histogram(best_idx24);

%     h0.Normalization='probability';

xlabel('Beam Pattern Number')
grid on
legend("K=4")
title("Best Beam Patterns M=2")


subplot(2,4,2)
h1=histogram(best_idx44);
hold on
h2=histogram(best_idx48);
% 
%     h1.Normalization='probability';
%     h2.Normalization='probability';

xlabel('Beam Pattern Number')
grid on
legend("K=4","K=8")
title("Best Beam Patterns M=4")


subplot(2,4,3)
h3=histogram(best_idx88);
hold on
h4=histogram(best_idx816);

%     h3.Normalization='probability';
%     h4.Normalization='probability';

xlabel('Beam Pattern Number')
grid on
legend("K=8","K=16")
title("Best Beam Patterns M=8")

subplot(2,4,4)
h5=histogram(best_idx1616);
hold on
h6=histogram(best_idx1632);
% 
%     h5.Normalization='probability';
%     h6.Normalization='probability';

xlabel('Beam Pattern Number')
grid on
legend("K=16","K=32")
title("Best Beam Patterns M=16")



    h0.FaceColor=[0.4940 0.1840 0.5560];

    h2.FaceColor=[0.4940 0.1840 0.5560];

    h4.FaceColor=[0.4940 0.1840 0.5560];

    h6.FaceColor=[0.4940 0.1840 0.5560];

   