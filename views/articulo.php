<?php
ob_start();
session_start();
if (!isset($_SESSION["nombre"])) {
  header("Location: login.html");
} else {
  include_once 'header.php';
  if ($_SESSION['almacen'] == 1) {
?>
    <!--Contenido-->
    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
      <!-- Main content -->
      <section class="content">
        <div class="row">
          <div class="col-md-12">
            <div class="box">
              <div class="box-header with-border">
                <h1 class="box-title">Artículo <button class="btn btn-success" onclick="mostrarform(true)" id="btnAgregar" name="btnAgregar"> Agregar <i class="fa fa-plus-circle"></i></button>  <a href="../reportes/rptarticulos.php"><button class="btn btn-info">Generar PDF</button></a></h1>
                <div class="box-tools pull-right">
                </div>
              </div>
              <!-- /.box-header -->
              <!-- centro -->
              <div class="panel-body table-responsive" id="listadoregistros">
                <table id="tbllistado" name="tbllistado" class="table table-striped table-bordered table-condensed table-hover">
                  <thead>
                    <th>Opciones</th>
                    <th>Nombre</th>
                    <th>Categoria</th>
                    <th>Código</th>
                    <th>Stock</th>
                    <th>Imagen</th>
                    <th>Estado</th>
                  </thead>
                  <tbody>

                  </tbody>
                  <tfoot>
                    <th>Opciones</th>
                    <th>Nombre</th>
                    <th>Categoria</th>
                    <th>Código</th>
                    <th>Stock</th>
                    <th>Imagen</th>
                    <th>Estado</th>
                  </tfoot>
                </table>
              </div>
              <div class="panel-body" id="formularioregistros">
                <form name="formulario" id="formulario" method="post">
                  <div class="form-group col-12">
                    <input class="form-control" type="hidden" name="idarticulo" id="idarticulo" readonly>
                  </div>
                  <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <label>*Nombre: </label>

                    <input class="form-control" type="text" name="nombre" id="nombre" maxlenght="100" placeholder="Nombre" required>
                  </div>
                  <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <label>*Categoría: </label>
                    <select name="idcategoria" id="idcategoria" class="form-control selectpicker" required></select>
                  </div>
                  <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <label>*Stock: </label>
                    <input type="number" name="stock" id="stock" required class="form-control">
                  </div>
                  <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <label>Descripción: </label>
                    <input class="form-control" type="text" name="descripcion" id="descripcion" maxlenght="256" placeholder="Descripción">
                  </div>
                  <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <label>Imagen: </label>
                    <input class="form-control" type="file" name="imagen" id="imagen">
                    <input class="form-control" type="hidden" name="imagenactual" id="imagenactual">
                    <img src=" " widht="150" height="150" id="imagenmuestra" name="imagenmuestra">
                  </div>
                  <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <label>*Código: </label>
                    <input class="form-control" type="text" name="codigo" id="codigo" placeholder="Código de barras">
                    <button class="btn btn-success" type="button" onClick="generarbarcode()">Generar código</button>
                    <div class="print">
                      <svg id="barcode" name="barcode"> </svg>
                    </div>
                  </div>
                  <div class="form-group col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <button class="btn btn-primary " type="submit" id="btnGuardar"><i class="fa fa-save"></i> Guardar</button>
                    <button class="btn btn-danger " onClick="cancelarform()" type="button"> <i class="fa fa-arrow-circle-left" aria-hidden="true"></i> Cancelar</button>

                  </div>
                </form>
              </div>
              <!--Fin centro -->
            </div><!-- /.box -->
          </div><!-- /.col -->
        </div><!-- /.row -->
      </section><!-- /.content -->

    </div><!-- /.content-wrapper -->
    <!--Fin-Contenido-->
  <?php
  } else {
    require 'noacceso.php';
  }
  include_once 'footer.php';
  ?>
  <script type="text/javascript" src="../public/js/JsBarcode.all.min.js"></script>
  <script type="text/javascript" src="scripts/articulo.js"></script>
<?php
}
ob_end_flush();
