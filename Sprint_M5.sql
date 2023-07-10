create database sprintm5;
use sprintm5;

create table usuarios (
	id_usuario int not null primary key,
    nombre_usuario varchar(15),
    apellido_usuario varchar(15),
    correo_usuario varchar(45),
    n_veces_utliza int default 1
);

create table operarios (
	id_operario int not null primary key,
    nombre_operario varchar(15),
    apellido_operario varchar(15),
    correo_operario varchar(45),
    n_veces_soporte int default 1    
);

create table soportes (
	codigo_soporte int auto_increment primary key,
    fecha_soporte date,
    id_operario int not null,
    id_usuario int not null,
    evaluacion set('1','2','3','4','5','6','7'),
    CONSTRAINT usuario_soportes_fk FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
	CONSTRAINT operario_soportes_fk FOREIGN KEY (id_operario) REFERENCES operarios(id_operario)
);
/* 7=excsoporteselente  6=Muy Bueno  5=Bueno  4=Regular  3=menos que regular   2= malo   1=muy malo */


insert into usuarios value(100, 'Javier', 'Hernández', 'javi.hernandez@mail.com', 1);
insert into usuarios value(101, 'Eduardo', 'Bermúdez', 'edua.bermudez@mail.com', 2);
insert into usuarios value(102, 'Daniela', 'Alvarado', 'dany.alvarado@mail.com', 3);
insert into usuarios value(103, 'María Francisca', 'Olmedo', 'fran.olmedo@mail.com', 3);
insert into usuarios value(104, 'Cayetana', 'Aránguiz', 'caye.aranquiz@mail.com', 3);
insert into usuarios value(105, 'Rosario', 'Díaz', 'rosa.diaz@mail.com', 2);
insert into usuarios value(106, 'Benjamín', 'Rodríguez', 'benj.rodriguez@mail.com', 4);
insert into usuarios value(107, 'Daniel', 'Moyano', 'dani.moyano.@mail.com', 4);
select * from usuarios;

insert into operarios value(1000, 'Andrés', 'Fernández', 'andres.fernandez@mail.com', 4);
insert into operarios value(1001, 'Ramiro', 'Padilla', 'ramiro.padilla@mail.com', 4);
insert into operarios value(1002, 'Alberto', 'Aravena', 'alverto.aravena@mail.com', 4);
insert into operarios value(1003, 'Camila', 'Díaz', 'camila.diaz@mail.com', 4);
insert into operarios value(1004, 'Macarena', 'Valencia', 'macarena.valencia@mail.com', 0);
insert into operarios value(1005, 'Matilde', 'Rosas', 'matilde.rosas@mail.com', 2);
insert into operarios value(1006, 'Ana María', 'Villalobos', 'amaria.villalobos@mail.com', 2);
insert into operarios value(1007, 'Javier', 'Matamala', 'javier.matamala@mail.com', 2);
select * from operarios;

insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1000, 100, '4');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1000, 101, '5');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1001, 102, '6');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1001, 103, '7');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1002, 104, '4');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1002, 105, '5');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1003, 106, '6');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1003, 107, '7');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1005, 107, '3');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1006, 106, '4');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1007, 101, '5');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1000, 104, '6');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1000, 105, '7');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1001, 106, '2');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1001, 106, '3');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1002, 107, '4');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1002, 107, '5');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1003, 102, '6');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1003, 102, '7');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1005, 103, '5');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1006, 103, '6');
insert into soportes(fecha_soporte, id_operario, id_usuario, evaluacion) value(curdate(), 1007, 104, '7');
select * from soportes;


/*Seleccione las 3 operaciones con mejor evaluación.*/
select fecha_soporte, id_operario, id_usuario, evaluacion from soportes order by evaluacion desc limit 3;


/*Seleccione las 3 operaciones con menos evaluación.*/
select fecha_soporte, id_operario, id_usuario, evaluacion from soportes order by evaluacion asc limit 3;


/*Seleccione al operario que más soportes ha realizado.*/
select operarios.nombre_operario, operarios.apellido_operario, max(n_veces_soporte) from operarios
where n_veces_soporte  =  
	(select max(n_veces_soporte) from operarios)
group by operarios.nombre_operario, operarios.apellido_operario;


/*Seleccione al cliente que menos veces ha utilizado la aplicación.*/
select operarios.nombre_operario, operarios.apellido_operario, min(n_veces_soporte) from operarios
where n_veces_soporte  =  
	(select min(n_veces_soporte) from operarios)
group by operarios.nombre_operario, operarios.apellido_operario;


/*Agregue 10 años a los tres primeros usuarios registrados.*/
update soportes set fecha_soporte = date_add(fecha_soporte, interval 10 year)
where codigo_soporte < 48;
select * from soportes;


/*Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.*/
alter table usuarios change correo_usuario mail varchar(45);
alter table operarios change correo_operario mail varchar(45);



/*Seleccione solo los operarios mayores de 20 años.*/
/*--------------------------------------------------*/
/*No hay registro de edades, no fue solicitado. */
/*Si se refiere a que llevan 20 o más años de servicio, esto sería: */
/*--------------------------------------------------------------------------------------*/
select operarios.nombre_operario, operarios.apellido_operario from operarios 
inner join soportes
on operarios.id_operario = soportes.id_operario
where DATEDIFF(curdate(), fecha_soporte) > 20*365;
/*--------------------------------------------------------------------------------------*/
/*obviamente, dados mis datos, con fecha actual para cada servicio, no hay resultados*/
/*forzando la tabla de "soportes", pondremos una fecha soporte antigua, mas de 20 años*/
/*--------------------------------------------------------------------------------------*/
update soportes set fecha_soporte = date_add(fecha_soporte, interval -40 year)
where codigo_soporte = 48;
/*--------------------------------------------------------------------------------------*/
/*Entonces ahora podemos ejecutar la query, obteniendo resultados*/


