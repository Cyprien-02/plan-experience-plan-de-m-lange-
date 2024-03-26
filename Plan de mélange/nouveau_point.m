function [X]=nouveau_point(m_a,m_b,a,b)

    X(1)=rand()*(m_b(1)-m_a(1))+m_a(1);
    k_1=max(a(2),1-X(1)-m_b(3)); % à priori toujours a(2) ??? bizarre
    k_2=min(b(2),1-X(1)-m_a(3));
    X(2)=rand(1).*(k_2-k_1)+k_1;
    X(3)=1-X(1)-X(2);
end