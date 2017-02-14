/****** Object:  StoredProcedure [dbo].[spCuprumEjecutaDespues]    Script Date: 19/09/2016 03:39:54 p.m. ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spCuprumEjecutaDespues]          
	@Modulo  CHAR(5),          
	@ID          int,            
	@Accion      char(20),            
	@Base        char(20),            
	@GenerarMov  char(20),            
	@Usuario     char(10),            
	@Ok          int          OUTPUT,            
	@OkRef       varchar(255)  OUTPUT,          
	--          
	@FacturaID  INT OUTPUT           

AS BEGIN          

DECLARE 
  @Oid_gasto		int,
	@Estatus        CHAR(15),
	@fecharegistro  datetime = getdate(),
  --Kike Sierra: 2015-10-20
  @Mov CHAR(20),
  @MovID VARCHAR(20),
  @MovTipo CHAR(20),
  @Cup_VtaMostrador BIT   ,
  @IdGasto int,
  -- Kike Sierra: 2016-09-16
  @GenerarMovTipo CHAR(20)
 
            
 /*** Apartado Prod *****/          

 IF @modulo = 'PROD'          
 BEGIN          
  --Kike Sierra: 11/07/2013: Procedimiento para la cancelacion parcial de produccion.          
  EXEC dbo.spCuprumCancelacionParcialProd @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT           
  --Carlos Jimenez: 04/02/2015: Procedimiento para enviar correo del inventario actual del material puesto en la Orden de Produccion
  EXEC CUP_SPQ_InventarioProduccion @Modulo, @ID, @Accion
 END          
          

 /*** Apartado INV *****/          
 IF @modulo = 'INV'          
 BEGIN          
  --Kike Sierra: 11/07/2013: Procedimiento para la la devolucion merma en las Ordenes Consumo          
  EXEC dbo.spCuprumCancelacionParcialProd @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT           

  --MZUNIGAF: 16/03/2015: Procedimiento para eliminar decimales en transitos y Concluirlos
  EXEC dbo.spCuprumConcluyeTransito @Modulo,@ID

 END          

          

  /*** Apartado VTAS *****/          
  IF @Modulo = 'VTAS'          

  BEGIN         

    ----Kike Sierra: 20/OCT/2015: 

    SELECT 
      @Mov = v.Mov,
      @MovID = v.MovID,
      @MovTipo = t.Clave,
      @CUP_VtaMostrador = v.CUP_VtaMostrador,
      @Estatus = v.Estatus
    FROM
      Venta v
    JOIN movtipo t ON @Modulo = t.Modulo
                    AND v.Mov = t.Mov
    WHERE 
      v.ID = @ID
   

      --

    --Kike Sierra: 15/10/2013 : Informa cuando una Orden C esta repetida          
    EXEC dbo.spCuprumInformaVtaOrdenC @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT           
        

      --Kike SIerra 20/04/2014: Procedimiento almacenado encargado de controlar el flujo de las Factuars Anticipo automaticas dentro del apartado de vtas        
    EXEC dbo.spCuprumVentaPedidoFactA @ID,@Usuario,2,@Accion,@GenerarMov,0          
       

    --Kike Sierra: 27/06/2014 : Actualiza el DMovID del movflujo de las cotizaciones que se mandaron a venta perdida.        
    EXEC dbo.spCuprumCotizacionVtaPerdida @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT         

       

    -- Erika Ramirez: 07/07/2014: Sp para llenar tabla de disposiciones en las devoluciones: Andres Balderas      
    EXEC CUP_Interface_Disposiciones @id, @Modulo      
   

    -- Kike Sierra:  08/Ene/2015: Procedimiento encargado de actualizar los valores de las facturas al caer en Cxc.
    EXEC CUP_SPU_VtasToCxcFields @Modulo, @ID, @MovTipo, @Accion



    ----Kike Sierra: 01/10/2015 : Encargado de Facturar y Cobrar la Venta Mostrador. 

    IF ISNULL(@CUP_VtaMostrador,0) = 1 
    BEGIN
      EXEC CUP_spp_FacturarVentaMostrador 
                  @Modulo       = @Modulo,     
                  @ID           = @ID,    
                  @Mov	  	    = @Mov,
                  @MovID        = @MovId,
                  @MovTipo     	= @MovTipo,
                  @Estatus	 	  = @Estatus,
                  @EstatusNuevo = NULL ,
                  @Accion       = @Accion,       
                  @Base         = @Base,  
                  @GenerarMov = @GenerarMov,          
                  @Usuario      = @Usuario,   
    @Ok     = @OK  OUTPUT,
                  @OkReF        = @OkRef  OUTPUT

    END
    --
    
    
    --Carlos Orozco: 11/07/2016: Generar Log Para Guardar la Estrategia Utilizada
    EXEC CUP_SPI_LogVentaDescuentos @ID, @Mov, @MovTipo

  END          
        
           
  /*** Apartado COMS *****/          
  IF @Modulo = 'COMS'          
  BEGIN          

    SELECT 
      @Mov = c.Mov,
      @MovTipo = t.Clave,
      @GenerarMovTipo = gt.Clave
    FROM
      Compra c
    JOIN movtipo t ON t.Modulo = @MODULO  
                  AND t.Mov = c.Mov
    LEFT JOIN Movtipo gt ON gt.Modulo = @Modulo
                        AND gt.Mov = @GenerarMov
    WHERE 
      c.ID = @ID

    -- Kike Sierra: 2013/07/17: Procedimiento para la actualizacion de la tabla CuprumAnexo, segun el certificado especificado en SerieLoteMov          
    EXEC dbo.spCuprumAnexoCertificado @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT           
            
    -- Kike Sierra: 2013/10/09: Procedimiento encargado de aplicar de manera automática los anticipos a Entradas de Compra.          
    EXEC dbo.spCuprumAplicacionAutoAnticipoOrdenC @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT      
   
    -- Kike Sierra: 2015/04/09: Procedimiento encargado de recalcular el vencimiento de los controles de calidad y sus Entradas.          
    EXEC dbo.spCMLRecalcularVencimientoCOMS @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT  

    -- Kike Sierra: 2016/09/19: Procedimiento almacenado encargado de enviar las notificaciones sobre compras especiales.
    EXEC dbo.CUP_SPP_NotificarCompraEspecial
	    @Modulo,         
	    @ID,          
	    @Accion,        
	    @Base, 
      @Estatus,
      @Mov,
      @MovTipo,   
	    @GenerarMov,
      @GenerarMovTipo,     
	    @Usuario,
      @OK OUTPUT,
      @OkRef OUTPUT       
   

  END          

             

/*** Apartado Cxc *****/        
 IF @modulo = 'CXC'        
 BEGIN        
  --Kike SIerra 20/04/2014: Procedimiento almacenado encargado de controlar el flujo de las Factuars Anticipo automaticas dentro del apartado de cxc        
  EXEC spCuprumCxcPedidoFactA @ID,@Usuario,1,@Accion,@GenerarMov     
    
    --Kike Sierra: 30/07/2014: Actualiza la fecha de Vencimiento de un cheque devuelto .en base al cheque asignado      
  EXEC spCuprumVencimientoChequeDevuelto @Modulo,@ID,@Accion,'AVANZAR',@Ok OUTPUT,@OkRef OUTPUT       
      
 END        

     

           

 /*** Apartado Cxp *****/          
 IF @modulo = 'CXP'          
 BEGIN          
  --Kike Sierra 01/10/2013: Procedimiento almacenado encargado de enviar correos automaticos sobre pagos.          
  EXEC dbo.spCuprumEnvioCorreoPagoProveedor @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT           
 END          

 /*** Apartado DIN *****/          

 if @modulo  ='DIN'
 BEGIN

 if EXISTS(	SELECT 	1 
			FROM dbo.fnCMLMovFlujo('DIN',@id,1) mf 
	    	join Cxp c on c.ID = mf.oid
			where mf.OMovTipo ='CXP.A' AND
			c.GenerarDinero =0              )
	BEGIN
		declare @oid INT

	SELECT  @oid = mf.OID 
			FROM dbo.fnCMLMovFlujo('DIN',@id,1) mf 
	    	join Cxp c on c.ID = mf.oid
			where mf.OMovTipo ='CXP.A' AND
			c.GenerarDinero =0

		update CUP_anticipo set id_estatus = 6 where ID_Anticipo  =@oid
	END		
 END


 /*** Apartado EMB *****/          
 

 if @modulo =  'EMB'
	BEGIN
		if EXISTS(SELECT 1 
					FROM MovFlujo mf 
					join gasto g on g.id = mf.dID 
					join Embarque e on e.id= mf.OID
					WHERE mf.OModulo = 'EMB' AND 
						  OID = @id AND 
						  DModulo = 'GAS' AND 
						  DMov = 'Gastos Fletes' AND 
						  g.Estatus ='Borrador' AND
						  g.Situacion ='Actualizar Datos' AND
						  e.Estatus  ='Cancelado' and
						  Cancelado = 1)
	BEGIN
			select @IdGasto = mf.DID FROM MovFlujo mf 
					join gasto g on g.id = mf.dID 
					join Embarque e on e.id= mf.OID
					WHERE mf.OModulo = 'EMB' AND 
						  e.Estatus ='CANCELADO' and
						  OID = @id AND 
						  DModulo = 'GAS' AND 
						  DMov = 'Gastos Fletes' AND 
						  g.Estatus ='Borrador' AND
						  g.Situacion ='Actualizar Datos' AND
						  e.Estatus  ='Cancelado' and
						  Cancelado = 1

			if not exists(select 1 from  EmpresaCfgValidarFechasEx where Empresa ='CML' and Modulo ='GAS' and Mov='Gastos Fletes')
				begin	
				   insert into EmpresaCfgValidarFechasEx values('CML','GAS','Gastos Fletes')
				END
			
			if not exists(select 1 from  CuprumExcepcionMovPeriodoCerrado where Empresa ='CML' and Modulo ='GAS' and Mov='Gastos Fletes')
				begin	
				   insert into CuprumExcepcionMovPeriodoCerrado values('CML','GAS','Gastos Fletes')
				END

			exec spAfectar 'GAS', @idGasto, 'CANCELAR', 'Todo', NULL, 'PRODAUT'

			delete from EmpresaCfgValidarFechasEx where Modulo ='GAS' and Empresa ='CML' and Mov ='Gastos Fletes'

			delete from CuprumExcepcionMovPeriodoCerrado where Modulo ='GAS' and Empresa ='CML' and Mov ='Gastos Fletes'
	END
END
            

          

           

 /*** Apartado Varios ( Dos o mas modulos, donde no requiera que se valide el modulo antes de ejecutar el procedimiento)           

 ya sea por que dentro del mismo procedimiento lo valide. O el efecto sea igual para todos ***************************/          

  --Kike SIerra 12/09/2013: Procedimiento almacenado que genera traspasos automaicos a partir de un movimiento de pedido especifico.          

  EXEC dbo.spCUPRUMPedidoTraspasoAuto @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,1,@Ok OUTPUT,@Okref OUTPUT,@FacturaID  OUTPUT            

            

  --Kike SIerra 16/10/2013 Prcedimiento almacenado que se encarga de "arrastrar" la situacion en las afectaciones.          

  EXEC dbo.spCuprumArrastraSituacion @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT          

          

  --Kike Sierra: 03/09/2013: Procedimiento Almacenado Encargado de Disparar Gastos al concluir Embarques.          

  EXEC spCuprumEmbarqueGasto @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT           

        

    --Kike SIerra 01/07/2014 Prcedimiento almacenado que se encarga de "arrastrar" las facturas de compras y gasto a cxp.  

  EXEC dbo.spCuprumArrastraFacturasComsGas @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,@Ok OUTPUT,@Okref OUTPUT        

      

        -- Erika Ramirez: 04/08/2014: sp para enviar correo de clientes especiales al colocar pedidos: Carlos Jimenez    

  EXEC dbo.CUP_SPP_ValidaCteEspecial @id, @Modulo    

    

      

  IF @modulo = 'GAS' AND @Accion = 'CANCELAR'    

  BEGIN       

     UPDATE MovFlujo SET Cancelado=1 WHERE DModulo='GAS' AND OModulo='EMB' AND Cancelado=0 AND DID=@ID AND DMov = 'Gastos Fletes'    

      

      

      -- Cuando el gasto se cancela, el embarque se le marca con la situacion de que se cancelo el gasto flete

           

    SELECT  @Oid_gasto = Oid, 

            @estatus = Embarque.Estatus

      FROM MovFlujo 

      inner join embarque on embarque.id = movflujo.oid

     WHERE DID = @ID 

       AND DModulo = 'GAS'

       AND DMov = 'Gastos Fletes'    

     

     IF @estatus NOT IN ('CONCLUIDO', 'CANCELADO')

      BEGIN

           EXEC spCambiarSituacion 'EMB', @Oid_gasto,'Gastos Fletes Cancelado' , @fecharegistro, @Usuario, NULL, NULL    

      END

   END   



--Kike Sierra 12/05/2015: Procedimiento Almacenado encargado de realizar los cambios en fecha requerida  de "Oferta Servicio" de las solicitudes Despues de afectar.

  EXEC spCMLServicioSolicitud @Modulo,@ID,@Accion,@Base,@GenerarMov,@Usuario,'DESPUESAFECTAR',@Ok OUTPUT,@OkRef OUTPUT                          

        

                 

RETURN          

END 






GO

