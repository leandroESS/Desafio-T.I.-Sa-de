/*Erro de criação da tabela agendamento, o tipo idEspecialidade na tabela tava varchar, 
mas referenciava a tabela especialidades com id INT, modifiquei para int*/

USE tisaude;

select count(a.idUsuario) , u.nome 
from usuarios u inner join  agendamentos a 
on a.idUsuario = u.id
and a.dataatendido is not null
group by u.nome 
order by count(a.idUsuario) desc; 


