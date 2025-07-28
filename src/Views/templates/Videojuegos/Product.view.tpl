<section class="container-m row px-4 py-4">
  <h1>{{FormTitle}}</h1>
</section>
<section class="container-m row px-4 py-4">
  {{with product}}
  <form action="index.php?page=Videojuegos-Product&mode={{~mode}}&productId={{productId}}" method="POST" class="col-12 col-m-8 offset-m-2">
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productId">Código</label>
      <input class="col-12 col-m-9" readonly disabled type="text" name="productId" id="productId" placehoder="Código" value="{{productId}}" />
      <input type="hidden" name="mode" value="{{~mode}}" />
      <input type="hidden" name="productId" value="{{productId}}" />
      <input type="hidden" name="product_xss_token" value="{{~product_xss_token}}" />
    </div>
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productName">Producto</label>
      <input class="col-12 col-m-9" {{~readonly}} type="text" name="productName" id="productName" placehoder="Nombre del Producto" value="{{productName}}" />
      {{if productName_error}}
      <div class="col-12 col-m-9 offset-m-3 error">
        {{productName_error}}
      </div>
      {{endif productName_error}}
    </div>
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productDescription">Descripción</label>
      <textarea class="col-12 col-m-9"  {{~readonly}} name="productDescription" id="productDescription" placehoder="Descripción del Producto">{{productDescription}}</textarea>
      {{if productDescription_error}}
      <div class="col-12 col-m-9 offset-m-3 error">
        {{productDescription_error}}
      </div>
      {{endif productDescription_error}}
    </div>
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productPrice">Precio</label>
      <input class="col-12 col-m-9" {{~readonly}} type="number" name="productPrice" id="productPrice" placehoder="Precio" value="{{productPrice}}" />
      {{if productPrice_error}}
      <div class="col-12 col-m-9 offset-m-3 error">
        {{productPrice_error}}
      </div>
      {{endif productPrice_error}}
    </div>
    <!-- Campo de stock agregado aquí -->
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productStock">Stock</label>
      <input class="col-12 col-m-9" {{~readonly}} type="number" name="productStock" id="productStock" placeholder="Stock" value="{{productStock}}" />
      {{if productStock_error}}
      <div class="col-12 col-m-9 offset-m-3 error">
        {{productStock_error}}
      </div>
      {{endif productStock_error}}
    </div>
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="productStatus">Estado</label>
      <select name="productStatus" id="productStatus" class="col-12 col-m-9" {{if ~readonly}} readonly disabled {{endif ~readonly}}>
        <option value="ACT" {{productStatus_act}}>Activo</option>
        <option value="INA" {{productStatus_ina}}>Inactivo</option>
      </select>
    </div>
    <div class="row my-2 align-center">
  <label class="col-12 col-m-3" for="productImgUrl">URL de Imagen</label>
  <input class="col-12 col-m-9" {{~readonly}} type="text" id="productImgUrl" name="productImgUrl" value="{{productImgUrl}}" placeholder="URL de Imagen" />
  {{if productImgUrl_error}}
  <div class="col-12 col-m-9 offset-m-3 error">
    {{productImgUrl_error}}
  </div>
  {{endif productImgUrl_error}}
</div>

{{if productImgUrl}}
<div class="row my-2 align-center">
  <div class="col-12 col-m-3"></div>
  <div class="col-12 col-m-9">
    <label>Vista previa de imagen:</label><br />
    <img src="{{productImgUrl}}" alt="Imagen del producto" style="max-width: 300px; max-height: 300px;" />
  </div>
</div>
{{endif productImgUrl}}
    
    {{endwith product}}
    <div class="row my-4 align-center flex-end">
      {{if showCommitBtn}}
      <button class="primary col-12 col-m-2" type="submit" name="btnConfirmar">Confirmar</button>
      &nbsp;
      {{endif showCommitBtn}}
      <button class="col-12 col-m-2"type="button" id="btnCancelar">
        {{if showCommitBtn}}
        Cancelar
        {{endif showCommitBtn}}
        {{ifnot showCommitBtn}}
        Regresar
        {{endifnot showCommitBtn}}
      </button>
    </div>
    </div>
  </form>
</section>

<script>
  document.addEventListener("DOMContentLoaded", ()=>{
    const btnCancelar = document.getElementById("btnCancelar");
    btnCancelar.addEventListener("click", (e)=>{
      e.preventDefault();
      e.stopPropagation();
      window.location.assign("index.php?page=Videojuegos-Products");
    });
  });
</script>
