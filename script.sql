
CREATE TABLE AgendaMedica
( 
	ID_Agenda            varchar(10)  NOT NULL ,
	DiaSemana_Age        varchar(10)  NOT NULL ,
	HoraInicio_Age       datetime  NOT NULL ,
	HoraFin_Age          datetime  NOT NULL ,
	DisponibleSiNo       varchar(5)  NOT NULL ,
	ID_Medico            integer  NOT NULL ,
	ID_Centro            varchar(15)  NOT NULL 
)
go



ALTER TABLE AgendaMedica
	ADD CONSTRAINT XPKAgendaMedica PRIMARY KEY  CLUSTERED (ID_Agenda ASC)
go



CREATE TABLE CentroSalud
( 
	ID_Centro            varchar(15)  NOT NULL ,
	Nom_Cent             varchar(30)  NOT NULL ,
	Direc_Cent           varchar(50)  NOT NULL ,
	Telef_Cent           varchar(12)  NOT NULL ,
	Tipo_Cent            varchar(20)  NOT NULL 
)
go



ALTER TABLE CentroSalud
	ADD CONSTRAINT XPKCentroSalud PRIMARY KEY  CLUSTERED (ID_Centro ASC)
go



CREATE TABLE Citas
( 
	ID_Citas             varchar(12)  NOT NULL ,
	Fecha_Cit            datetime  NOT NULL ,
	HorIni_Cit           datetime  NOT NULL ,
	HorFin_Cit           datetime  NOT NULL ,
	Estad_Cit            varchar(12)  NOT NULL ,
	Tipo_Cit             varchar(20)  NOT NULL ,
	Motivo_Cit           varchar(50)  NOT NULL ,
	ID_Medico            integer  NOT NULL ,
	ID_paciente          integer  NOT NULL ,
	ID_Centro            varchar(15)  NOT NULL 
)
go



ALTER TABLE Citas
	ADD CONSTRAINT XPKCitas PRIMARY KEY  CLUSTERED (ID_Citas ASC)
go



CREATE TABLE HistorialClinico
( 
	ID_Historial         varchar(7)  NOT NULL ,
	FechRgstr_Hist       datetime  NOT NULL ,
	Diagnóstico          varchar(100)  NOT NULL ,
	Tratamiento          varchar(100)  NOT NULL ,
	Observaciones        varchar(100)  NOT NULL ,
	ID_Citas             varchar(12)  NOT NULL 
)
go



ALTER TABLE HistorialClinico
	ADD CONSTRAINT XPKHistorialClinico PRIMARY KEY  CLUSTERED (ID_Historial ASC)
go



CREATE TABLE LogAcceso
( 
	ID_Log               varchar(10)  NOT NULL ,
	FechHora_Log         datetime  NOT NULL ,
	Accion_Log           varchar(20)  NOT NULL ,
	ID_User              char(18)  NOT NULL 
)
go



ALTER TABLE LogAcceso
	ADD CONSTRAINT XPKLogAcceso PRIMARY KEY  CLUSTERED (ID_Log ASC)
go



CREATE TABLE Médico
( 
	ID_Medico            integer  NOT NULL ,
	Nom_Med              varchar(30)  NOT NULL ,
	Ape_Med              varchar(50)  NOT NULL ,
	Direc_Med            varchar(70)  NOT NULL ,
	Espe_Med             varchar(30)  NOT NULL ,
	Telef_Med            integer  NULL ,
	ID_Centro            varchar(15)  NOT NULL ,
	ID_User              char(18)  NOT NULL 
)
go



ALTER TABLE Médico
	ADD CONSTRAINT XPKMédico PRIMARY KEY  CLUSTERED (ID_Medico ASC,ID_Centro ASC)
go



CREATE TABLE Notificaciones
( 
	ID_Notificacion      varchar(10)  NOT NULL ,
	CnalPorEmail         varchar(20)  NOT NULL ,
	FechaEnvio           datetime  NOT NULL ,
	Estado_notif         varchar(12)  NOT NULL ,
	ID_Citas             varchar(12)  NOT NULL 
)
go



ALTER TABLE Notificaciones
	ADD CONSTRAINT XPKNotificaciones PRIMARY KEY  CLUSTERED (ID_Notificacion ASC)
go



CREATE TABLE Paciente
( 
	ID_paciente          integer  NOT NULL ,
	Ape_pac              varchar(50)  NOT NULL ,
	telef_pac            integer  NOT NULL ,
	Direc_pac            varchar(70)  NOT NULL ,
	FechNaci_pac         datetime  NOT NULL ,
	Gener_pac            varchar(10)  NOT NULL ,
	Nom_pac              varchar(50)  NOT NULL ,
	ID_User              char(18)  NOT NULL 
)
go



ALTER TABLE Paciente
	ADD CONSTRAINT XPKPaciente PRIMARY KEY  CLUSTERED (ID_paciente ASC)
go



CREATE TABLE ReporteGestion
( 
	ID_Reporte           char(18)  NOT NULL ,
	TotalCitas           integer  NOT NULL ,
	CitasCanceladas      integer  NOT NULL ,
	CitasModificadas     integer  NOT NULL ,
	CitasNoAsistidas     integer  NOT NULL ,
	CitasAtendidas       integer  NOT NULL ,
	ID_Centro            varchar(15)  NOT NULL 
)
go



ALTER TABLE ReporteGestion
	ADD CONSTRAINT XPKReporteGestion PRIMARY KEY  CLUSTERED (ID_Reporte ASC)
go



CREATE TABLE Roles
( 
	ID_Rol               varchar(10)  NOT NULL ,
	Nom_Rol              varchar(20)  NOT NULL 
)
go



ALTER TABLE Roles
	ADD CONSTRAINT XPKRoles PRIMARY KEY  CLUSTERED (ID_Rol ASC)
go



CREATE TABLE Usuario
( 
	ID_User              char(18)  NOT NULL ,
	Username_Us          char(18)  NOT NULL ,
	Contraseña_Us        char(18)  NOT NULL ,
	Correo_Us            char(18)  NOT NULL ,
	EstadoAc_Us          char(18)  NOT NULL ,
	ID_Rol               varchar(10)  NOT NULL 
)
go



ALTER TABLE Usuario
	ADD CONSTRAINT XPKUsuario PRIMARY KEY  CLUSTERED (ID_User ASC)
go




ALTER TABLE AgendaMedica
	ADD CONSTRAINT R_4 FOREIGN KEY (ID_Medico,ID_Centro) REFERENCES Médico(ID_Medico,ID_Centro)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Citas
	ADD CONSTRAINT R_6 FOREIGN KEY (ID_Medico,ID_Centro) REFERENCES Médico(ID_Medico,ID_Centro)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Citas
	ADD CONSTRAINT R_7 FOREIGN KEY (ID_paciente) REFERENCES Paciente(ID_paciente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Citas
	ADD CONSTRAINT R_10 FOREIGN KEY (ID_Centro) REFERENCES CentroSalud(ID_Centro)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE HistorialClinico
	ADD CONSTRAINT R_12 FOREIGN KEY (ID_Citas) REFERENCES Citas(ID_Citas)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE LogAcceso
	ADD CONSTRAINT R_21 FOREIGN KEY (ID_User) REFERENCES Usuario(ID_User)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Médico
	ADD CONSTRAINT R_9 FOREIGN KEY (ID_Centro) REFERENCES CentroSalud(ID_Centro)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Médico
	ADD CONSTRAINT R_19 FOREIGN KEY (ID_User) REFERENCES Usuario(ID_User)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Notificaciones
	ADD CONSTRAINT R_13 FOREIGN KEY (ID_Citas) REFERENCES Citas(ID_Citas)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Paciente
	ADD CONSTRAINT R_16 FOREIGN KEY (ID_User) REFERENCES Usuario(ID_User)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE ReporteGestion
	ADD CONSTRAINT R_22 FOREIGN KEY (ID_Centro) REFERENCES CentroSalud(ID_Centro)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Usuario
	ADD CONSTRAINT R_27 FOREIGN KEY (ID_Rol) REFERENCES Roles(ID_Rol)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




CREATE TRIGGER tD_AgendaMedica ON AgendaMedica FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on AgendaMedica */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Médico  AgendaMedica on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015b2b", PARENT_OWNER="", PARENT_TABLE="Médico"
    CHILD_OWNER="", CHILD_TABLE="AgendaMedica"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID_Medico""ID_Centro" */
    IF EXISTS (SELECT * FROM deleted,Médico
      WHERE
        /* %JoinFKPK(deleted,Médico," = "," AND") */
        deleted.ID_Medico = Médico.ID_Medico AND
        deleted.ID_Centro = Médico.ID_Centro AND
        NOT EXISTS (
          SELECT * FROM AgendaMedica
          WHERE
            /* %JoinFKPK(AgendaMedica,Médico," = "," AND") */
            AgendaMedica.ID_Medico = Médico.ID_Medico AND
            AgendaMedica.ID_Centro = Médico.ID_Centro
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last AgendaMedica because Médico exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_AgendaMedica ON AgendaMedica FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on AgendaMedica */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_Agenda varchar(10),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Médico  AgendaMedica on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00017165", PARENT_OWNER="", PARENT_TABLE="Médico"
    CHILD_OWNER="", CHILD_TABLE="AgendaMedica"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID_Medico""ID_Centro" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Medico) OR
    UPDATE(ID_Centro)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Médico
        WHERE
          /* %JoinFKPK(inserted,Médico) */
          inserted.ID_Medico = Médico.ID_Medico and
          inserted.ID_Centro = Médico.ID_Centro
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update AgendaMedica because Médico does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_CentroSalud ON CentroSalud FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on CentroSalud */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* CentroSalud  Médico on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002d223", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="Médico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="ID_Centro" */
    IF EXISTS (
      SELECT * FROM deleted,Médico
      WHERE
        /*  %JoinFKPK(Médico,deleted," = "," AND") */
        Médico.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete CentroSalud because Médico exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* CentroSalud  Citas on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="ID_Centro" */
    IF EXISTS (
      SELECT * FROM deleted,Citas
      WHERE
        /*  %JoinFKPK(Citas,deleted," = "," AND") */
        Citas.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete CentroSalud because Citas exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* CentroSalud  ReporteGestion on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="ReporteGestion"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="ID_Centro" */
    IF EXISTS (
      SELECT * FROM deleted,ReporteGestion
      WHERE
        /*  %JoinFKPK(ReporteGestion,deleted," = "," AND") */
        ReporteGestion.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete CentroSalud because ReporteGestion exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_CentroSalud ON CentroSalud FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on CentroSalud */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_Centro varchar(15),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* CentroSalud  Médico on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00034906", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="Médico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="ID_Centro" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Centro)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Médico
      WHERE
        /*  %JoinFKPK(Médico,deleted," = "," AND") */
        Médico.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update CentroSalud because Médico exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* CentroSalud  Citas on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="ID_Centro" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Centro)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Citas
      WHERE
        /*  %JoinFKPK(Citas,deleted," = "," AND") */
        Citas.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update CentroSalud because Citas exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* CentroSalud  ReporteGestion on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="ReporteGestion"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="ID_Centro" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Centro)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,ReporteGestion
      WHERE
        /*  %JoinFKPK(ReporteGestion,deleted," = "," AND") */
        ReporteGestion.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update CentroSalud because ReporteGestion exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Citas ON Citas FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Citas */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Citas  HistorialClinico on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00057d20", PARENT_OWNER="", PARENT_TABLE="Citas"
    CHILD_OWNER="", CHILD_TABLE="HistorialClinico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="ID_Citas" */
    IF EXISTS (
      SELECT * FROM deleted,HistorialClinico
      WHERE
        /*  %JoinFKPK(HistorialClinico,deleted," = "," AND") */
        HistorialClinico.ID_Citas = deleted.ID_Citas
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Citas because HistorialClinico exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Citas  Notificaciones on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Citas"
    CHILD_OWNER="", CHILD_TABLE="Notificaciones"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="ID_Citas" */
    IF EXISTS (
      SELECT * FROM deleted,Notificaciones
      WHERE
        /*  %JoinFKPK(Notificaciones,deleted," = "," AND") */
        Notificaciones.ID_Citas = deleted.ID_Citas
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Citas because Notificaciones exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Médico  Citas on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Médico"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="ID_Medico""ID_Centro" */
    IF EXISTS (SELECT * FROM deleted,Médico
      WHERE
        /* %JoinFKPK(deleted,Médico," = "," AND") */
        deleted.ID_Medico = Médico.ID_Medico AND
        deleted.ID_Centro = Médico.ID_Centro AND
        NOT EXISTS (
          SELECT * FROM Citas
          WHERE
            /* %JoinFKPK(Citas,Médico," = "," AND") */
            Citas.ID_Medico = Médico.ID_Medico AND
            Citas.ID_Centro = Médico.ID_Centro
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Citas because Médico exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Paciente  Citas on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Paciente"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="ID_paciente" */
    IF EXISTS (SELECT * FROM deleted,Paciente
      WHERE
        /* %JoinFKPK(deleted,Paciente," = "," AND") */
        deleted.ID_paciente = Paciente.ID_paciente AND
        NOT EXISTS (
          SELECT * FROM Citas
          WHERE
            /* %JoinFKPK(Citas,Paciente," = "," AND") */
            Citas.ID_paciente = Paciente.ID_paciente
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Citas because Paciente exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* CentroSalud  Citas on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="ID_Centro" */
    IF EXISTS (SELECT * FROM deleted,CentroSalud
      WHERE
        /* %JoinFKPK(deleted,CentroSalud," = "," AND") */
        deleted.ID_Centro = CentroSalud.ID_Centro AND
        NOT EXISTS (
          SELECT * FROM Citas
          WHERE
            /* %JoinFKPK(Citas,CentroSalud," = "," AND") */
            Citas.ID_Centro = CentroSalud.ID_Centro
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Citas because CentroSalud exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Citas ON Citas FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Citas */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_Citas varchar(12),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Citas  HistorialClinico on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00060d58", PARENT_OWNER="", PARENT_TABLE="Citas"
    CHILD_OWNER="", CHILD_TABLE="HistorialClinico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="ID_Citas" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Citas)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,HistorialClinico
      WHERE
        /*  %JoinFKPK(HistorialClinico,deleted," = "," AND") */
        HistorialClinico.ID_Citas = deleted.ID_Citas
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Citas because HistorialClinico exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Citas  Notificaciones on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Citas"
    CHILD_OWNER="", CHILD_TABLE="Notificaciones"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="ID_Citas" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Citas)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Notificaciones
      WHERE
        /*  %JoinFKPK(Notificaciones,deleted," = "," AND") */
        Notificaciones.ID_Citas = deleted.ID_Citas
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Citas because Notificaciones exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Médico  Citas on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Médico"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="ID_Medico""ID_Centro" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Medico) OR
    UPDATE(ID_Centro)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Médico
        WHERE
          /* %JoinFKPK(inserted,Médico) */
          inserted.ID_Medico = Médico.ID_Medico and
          inserted.ID_Centro = Médico.ID_Centro
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Citas because Médico does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Paciente  Citas on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Paciente"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="ID_paciente" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_paciente)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Paciente
        WHERE
          /* %JoinFKPK(inserted,Paciente) */
          inserted.ID_paciente = Paciente.ID_paciente
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Citas because Paciente does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* CentroSalud  Citas on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="ID_Centro" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Centro)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,CentroSalud
        WHERE
          /* %JoinFKPK(inserted,CentroSalud) */
          inserted.ID_Centro = CentroSalud.ID_Centro
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Citas because CentroSalud does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_HistorialClinico ON HistorialClinico FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on HistorialClinico */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Citas  HistorialClinico on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00012d53", PARENT_OWNER="", PARENT_TABLE="Citas"
    CHILD_OWNER="", CHILD_TABLE="HistorialClinico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="ID_Citas" */
    IF EXISTS (SELECT * FROM deleted,Citas
      WHERE
        /* %JoinFKPK(deleted,Citas," = "," AND") */
        deleted.ID_Citas = Citas.ID_Citas AND
        NOT EXISTS (
          SELECT * FROM HistorialClinico
          WHERE
            /* %JoinFKPK(HistorialClinico,Citas," = "," AND") */
            HistorialClinico.ID_Citas = Citas.ID_Citas
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last HistorialClinico because Citas exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_HistorialClinico ON HistorialClinico FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on HistorialClinico */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_Historial varchar(7),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Citas  HistorialClinico on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00013d6c", PARENT_OWNER="", PARENT_TABLE="Citas"
    CHILD_OWNER="", CHILD_TABLE="HistorialClinico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="ID_Citas" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Citas)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Citas
        WHERE
          /* %JoinFKPK(inserted,Citas) */
          inserted.ID_Citas = Citas.ID_Citas
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update HistorialClinico because Citas does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_LogAcceso ON LogAcceso FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on LogAcceso */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Usuario  LogAcceso on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00012365", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="LogAcceso"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="ID_User" */
    IF EXISTS (SELECT * FROM deleted,Usuario
      WHERE
        /* %JoinFKPK(deleted,Usuario," = "," AND") */
        deleted.ID_User = Usuario.ID_User AND
        NOT EXISTS (
          SELECT * FROM LogAcceso
          WHERE
            /* %JoinFKPK(LogAcceso,Usuario," = "," AND") */
            LogAcceso.ID_User = Usuario.ID_User
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last LogAcceso because Usuario exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_LogAcceso ON LogAcceso FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on LogAcceso */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_Log varchar(10),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Usuario  LogAcceso on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000147de", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="LogAcceso"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="ID_User" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_User)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Usuario
        WHERE
          /* %JoinFKPK(inserted,Usuario) */
          inserted.ID_User = Usuario.ID_User
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update LogAcceso because Usuario does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Médico ON Médico FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Médico */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Médico  AgendaMedica on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000452fc", PARENT_OWNER="", PARENT_TABLE="Médico"
    CHILD_OWNER="", CHILD_TABLE="AgendaMedica"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID_Medico""ID_Centro" */
    IF EXISTS (
      SELECT * FROM deleted,AgendaMedica
      WHERE
        /*  %JoinFKPK(AgendaMedica,deleted," = "," AND") */
        AgendaMedica.ID_Medico = deleted.ID_Medico AND
        AgendaMedica.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Médico because AgendaMedica exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Médico  Citas on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Médico"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="ID_Medico""ID_Centro" */
    IF EXISTS (
      SELECT * FROM deleted,Citas
      WHERE
        /*  %JoinFKPK(Citas,deleted," = "," AND") */
        Citas.ID_Medico = deleted.ID_Medico AND
        Citas.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Médico because Citas exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* CentroSalud  Médico on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="Médico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="ID_Centro" */
    IF EXISTS (SELECT * FROM deleted,CentroSalud
      WHERE
        /* %JoinFKPK(deleted,CentroSalud," = "," AND") */
        deleted.ID_Centro = CentroSalud.ID_Centro AND
        NOT EXISTS (
          SELECT * FROM Médico
          WHERE
            /* %JoinFKPK(Médico,CentroSalud," = "," AND") */
            Médico.ID_Centro = CentroSalud.ID_Centro
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Médico because CentroSalud exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Usuario  Médico on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="Médico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="ID_User" */
    IF EXISTS (SELECT * FROM deleted,Usuario
      WHERE
        /* %JoinFKPK(deleted,Usuario," = "," AND") */
        deleted.ID_User = Usuario.ID_User AND
        NOT EXISTS (
          SELECT * FROM Médico
          WHERE
            /* %JoinFKPK(Médico,Usuario," = "," AND") */
            Médico.ID_User = Usuario.ID_User
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Médico because Usuario exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Médico ON Médico FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Médico */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_Medico integer, 
           @insID_Centro varchar(15),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Médico  AgendaMedica on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004c7ac", PARENT_OWNER="", PARENT_TABLE="Médico"
    CHILD_OWNER="", CHILD_TABLE="AgendaMedica"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_4", FK_COLUMNS="ID_Medico""ID_Centro" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Medico) OR
    UPDATE(ID_Centro)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,AgendaMedica
      WHERE
        /*  %JoinFKPK(AgendaMedica,deleted," = "," AND") */
        AgendaMedica.ID_Medico = deleted.ID_Medico AND
        AgendaMedica.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Médico because AgendaMedica exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Médico  Citas on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Médico"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="ID_Medico""ID_Centro" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Medico) OR
    UPDATE(ID_Centro)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Citas
      WHERE
        /*  %JoinFKPK(Citas,deleted," = "," AND") */
        Citas.ID_Medico = deleted.ID_Medico AND
        Citas.ID_Centro = deleted.ID_Centro
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Médico because Citas exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* CentroSalud  Médico on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="Médico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="ID_Centro" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Centro)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,CentroSalud
        WHERE
          /* %JoinFKPK(inserted,CentroSalud) */
          inserted.ID_Centro = CentroSalud.ID_Centro
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Médico because CentroSalud does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Usuario  Médico on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="Médico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="ID_User" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_User)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Usuario
        WHERE
          /* %JoinFKPK(inserted,Usuario) */
          inserted.ID_User = Usuario.ID_User
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Médico because Usuario does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Notificaciones ON Notificaciones FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Notificaciones */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Citas  Notificaciones on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00012977", PARENT_OWNER="", PARENT_TABLE="Citas"
    CHILD_OWNER="", CHILD_TABLE="Notificaciones"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="ID_Citas" */
    IF EXISTS (SELECT * FROM deleted,Citas
      WHERE
        /* %JoinFKPK(deleted,Citas," = "," AND") */
        deleted.ID_Citas = Citas.ID_Citas AND
        NOT EXISTS (
          SELECT * FROM Notificaciones
          WHERE
            /* %JoinFKPK(Notificaciones,Citas," = "," AND") */
            Notificaciones.ID_Citas = Citas.ID_Citas
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Notificaciones because Citas exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Notificaciones ON Notificaciones FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Notificaciones */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_Notificacion varchar(10),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Citas  Notificaciones on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00014e7b", PARENT_OWNER="", PARENT_TABLE="Citas"
    CHILD_OWNER="", CHILD_TABLE="Notificaciones"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="ID_Citas" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Citas)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Citas
        WHERE
          /* %JoinFKPK(inserted,Citas) */
          inserted.ID_Citas = Citas.ID_Citas
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Notificaciones because Citas does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Paciente ON Paciente FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Paciente */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Paciente  Citas on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00020480", PARENT_OWNER="", PARENT_TABLE="Paciente"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="ID_paciente" */
    IF EXISTS (
      SELECT * FROM deleted,Citas
      WHERE
        /*  %JoinFKPK(Citas,deleted," = "," AND") */
        Citas.ID_paciente = deleted.ID_paciente
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Paciente because Citas exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Usuario  Paciente on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="Paciente"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="ID_User" */
    IF EXISTS (SELECT * FROM deleted,Usuario
      WHERE
        /* %JoinFKPK(deleted,Usuario," = "," AND") */
        deleted.ID_User = Usuario.ID_User AND
        NOT EXISTS (
          SELECT * FROM Paciente
          WHERE
            /* %JoinFKPK(Paciente,Usuario," = "," AND") */
            Paciente.ID_User = Usuario.ID_User
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Paciente because Usuario exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Paciente ON Paciente FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Paciente */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_paciente integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Paciente  Citas on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00024392", PARENT_OWNER="", PARENT_TABLE="Paciente"
    CHILD_OWNER="", CHILD_TABLE="Citas"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_7", FK_COLUMNS="ID_paciente" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_paciente)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Citas
      WHERE
        /*  %JoinFKPK(Citas,deleted," = "," AND") */
        Citas.ID_paciente = deleted.ID_paciente
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Paciente because Citas exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Usuario  Paciente on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="Paciente"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="ID_User" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_User)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Usuario
        WHERE
          /* %JoinFKPK(inserted,Usuario) */
          inserted.ID_User = Usuario.ID_User
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Paciente because Usuario does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_ReporteGestion ON ReporteGestion FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on ReporteGestion */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* CentroSalud  ReporteGestion on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="0001408d", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="ReporteGestion"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="ID_Centro" */
    IF EXISTS (SELECT * FROM deleted,CentroSalud
      WHERE
        /* %JoinFKPK(deleted,CentroSalud," = "," AND") */
        deleted.ID_Centro = CentroSalud.ID_Centro AND
        NOT EXISTS (
          SELECT * FROM ReporteGestion
          WHERE
            /* %JoinFKPK(ReporteGestion,CentroSalud," = "," AND") */
            ReporteGestion.ID_Centro = CentroSalud.ID_Centro
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last ReporteGestion because CentroSalud exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_ReporteGestion ON ReporteGestion FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on ReporteGestion */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_Reporte char(18),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* CentroSalud  ReporteGestion on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00015481", PARENT_OWNER="", PARENT_TABLE="CentroSalud"
    CHILD_OWNER="", CHILD_TABLE="ReporteGestion"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="ID_Centro" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Centro)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,CentroSalud
        WHERE
          /* %JoinFKPK(inserted,CentroSalud) */
          inserted.ID_Centro = CentroSalud.ID_Centro
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update ReporteGestion because CentroSalud does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Roles ON Roles FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Roles */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Roles  Usuario on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000e529", PARENT_OWNER="", PARENT_TABLE="Roles"
    CHILD_OWNER="", CHILD_TABLE="Usuario"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="ID_Rol" */
    IF EXISTS (
      SELECT * FROM deleted,Usuario
      WHERE
        /*  %JoinFKPK(Usuario,deleted," = "," AND") */
        Usuario.ID_Rol = deleted.ID_Rol
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Roles because Usuario exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Roles ON Roles FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Roles */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_Rol varchar(10),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Roles  Usuario on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00010027", PARENT_OWNER="", PARENT_TABLE="Roles"
    CHILD_OWNER="", CHILD_TABLE="Usuario"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="ID_Rol" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_Rol)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Usuario
      WHERE
        /*  %JoinFKPK(Usuario,deleted," = "," AND") */
        Usuario.ID_Rol = deleted.ID_Rol
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Roles because Usuario exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_Usuario ON Usuario FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on Usuario */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* Usuario  Paciente on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003c18c", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="Paciente"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="ID_User" */
    IF EXISTS (
      SELECT * FROM deleted,Paciente
      WHERE
        /*  %JoinFKPK(Paciente,deleted," = "," AND") */
        Paciente.ID_User = deleted.ID_User
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Usuario because Paciente exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Usuario  Médico on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="Médico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="ID_User" */
    IF EXISTS (
      SELECT * FROM deleted,Médico
      WHERE
        /*  %JoinFKPK(Médico,deleted," = "," AND") */
        Médico.ID_User = deleted.ID_User
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Usuario because Médico exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Usuario  LogAcceso on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="LogAcceso"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="ID_User" */
    IF EXISTS (
      SELECT * FROM deleted,LogAcceso
      WHERE
        /*  %JoinFKPK(LogAcceso,deleted," = "," AND") */
        LogAcceso.ID_User = deleted.ID_User
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Usuario because LogAcceso exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* Roles  Usuario on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Roles"
    CHILD_OWNER="", CHILD_TABLE="Usuario"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="ID_Rol" */
    IF EXISTS (SELECT * FROM deleted,Roles
      WHERE
        /* %JoinFKPK(deleted,Roles," = "," AND") */
        deleted.ID_Rol = Roles.ID_Rol AND
        NOT EXISTS (
          SELECT * FROM Usuario
          WHERE
            /* %JoinFKPK(Usuario,Roles," = "," AND") */
            Usuario.ID_Rol = Roles.ID_Rol
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Usuario because Roles exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_Usuario ON Usuario FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on Usuario */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insID_User char(18),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* Usuario  Paciente on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00042fa4", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="Paciente"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_16", FK_COLUMNS="ID_User" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_User)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Paciente
      WHERE
        /*  %JoinFKPK(Paciente,deleted," = "," AND") */
        Paciente.ID_User = deleted.ID_User
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Usuario because Paciente exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Usuario  Médico on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="Médico"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_19", FK_COLUMNS="ID_User" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_User)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Médico
      WHERE
        /*  %JoinFKPK(Médico,deleted," = "," AND") */
        Médico.ID_User = deleted.ID_User
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Usuario because Médico exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Usuario  LogAcceso on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Usuario"
    CHILD_OWNER="", CHILD_TABLE="LogAcceso"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_21", FK_COLUMNS="ID_User" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(ID_User)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,LogAcceso
      WHERE
        /*  %JoinFKPK(LogAcceso,deleted," = "," AND") */
        LogAcceso.ID_User = deleted.ID_User
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Usuario because LogAcceso exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* Roles  Usuario on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Roles"
    CHILD_OWNER="", CHILD_TABLE="Usuario"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_27", FK_COLUMNS="ID_Rol" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(ID_Rol)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Roles
        WHERE
          /* %JoinFKPK(inserted,Roles) */
          inserted.ID_Rol = Roles.ID_Rol
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Usuario because Roles does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


