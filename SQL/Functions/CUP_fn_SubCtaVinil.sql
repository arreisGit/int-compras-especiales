SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO

IF EXISTS (SELECT name 
           FROM sysobjects 
           WHERE name = 'CUP_fn_SubCtaVinil') 
  DROP FUNCTION  CUP_fn_SubCtaVinil
GO

/* =============================================
  
  Created by:    Enrique Sierra Gtez
  Creation Date: 2017-02-16

  Description: Obtiene el valor del vinil de una subcuenta.

  EXAMPLE: 
  SELECT
   M1 = dbo.CUP_fn_SubCtaVinil('L3050M1'),
   M2 = dbo.CUP_fn_SubCtaVinil('M2'),
   M3 = dbo.CUP_fn_SubCtaVinil('A3050M3'),
   M4 = dbo.CUP_fn_SubCtaVinil('A3050M4Z5'),
   [NULL]  = dbo.CUP_fn_SubCtaVinil('L3050N1'),
   [NULL]  = dbo.CUP_fn_SubCtaVinil('3050'),
   empty = dbo.CUP_fn_SubCtaVinil(''),
   [NULL] = dbo.CUP_fn_SubCtaVinil(NULL)

   NOTE: All of the previous examples should return a valid integer from 1 to 4,
   with the exception ofthe last four, wich should return empty and null.

============================================= */

CREATE FUNCTION CUP_fn_SubCtaVinil
(
  @SubCuenta VARCHAR(20)
)
RETURNS VARCHAR(20)
AS BEGIN
  RETURN CASE
           WHEN @SubCuenta IS NULL
             THEN NULL
           ELSE 
             STUFF
             (
                dbo.RegExMatch('M[0-9]+',@SubCuenta,3),
                1,
                1,
                ''
             )
        END
END