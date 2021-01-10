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
                <h1 class="box-title">Categoria <button class="btn btn-success" onclick="mostrarform(true)" id="btnAgregar" name="btnAgregar"> Agregar <i class="fa fa-plus-circle"></i></button></h1>
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
                    <th>Descripción</th>
                    <th>Estado</th>
                  </thead>
                  <tbody>

                  </tbody>
                  <tfoot>
                    <th>Opciones</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Estado</th>
                  </tfoot>
                </table>
              </div>
              <div class="panel-body" id="formularioregistros">
                <form name="formulario" id="formulario" method="post">
                  <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <label for="my-input">Nombre</label>
                    <input class="form-control" type="hidden" name="idcategoria" id="idcategoria">
                    <input class="form-control" type="text" name="nombre" id="nombre" maxlenght="50" placeholder="Nombre" required>
                  </div>
                  <div class="form-group col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <label for="my-input">Descripción</label>
                    <input class="form-control" type="text" name="descripcion" id="descripcion" maxlenght="256" placeholder="Descripción">
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
  <script type="text/javascript" src="scripts/categoria.js"></script>
<?php
}
ob_end_flush();
?>