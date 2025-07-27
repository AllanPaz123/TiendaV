<section class="depth-2 px-2 py-2">
    <h2>{{modeDsc}}</h2>
</section>
<section class="grid py-4 px-4 my-4">
    <div class="row">
        <div class="col-12 offset-m-1 col-m-10 offset-l-3 col-l-6">
            <form class="row" action="index.php?page=Videojuegos-Product&mode={{mode}}&productId={{productId}}" method="post">
                <div class="row">
                    <label for="productId" class="col-12 col-m-4">Código</label>
                    <input readonly type="text" class="col-12 col-m-8" name="productId" id="productId" value="{{productId}}" />
                    <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
                </div>

                <div class="row">
                    <label for="productName" class="col-12 col-m-4">Nombre</label>
                    <input type="text" class="col-12 col-m-8" name="productName" id="productName" value="{{productName}}" {{readonly}} />
                    {{if error_productName}} 
                        <span class="error col-12 col-m-8">{{error_productName}}</span>
                    {{endif error_productName}}
                </div>

                <div class="row">
                    <label for="productDescription" class="col-12 col-m-4">Descripción</label>
                    <textarea class="col-12 col-m-8" name="productDescription" id="productDescription" {{readonly}}>{{productDescription}}</textarea>
                </div>

                <div class="row">
                    <label for="productPrice" class="col-12 col-m-4">Precio</label>
                    <input type="number" step="0.01" class="col-12 col-m-8" name="productPrice" id="productPrice" value="{{productPrice}}" {{readonly}} />
                    {{if error_productPrice}} 
                        <span class="error col-12 col-m-8">{{error_productPrice}}</span>
                    {{endif error_productPrice}}
                </div>

                <div class="row">
                    <label for="productStock" class="col-12 col-m-4">Stock</label>
                    <input type="number" class="col-12 col-m-8" name="productStock" id="productStock" value="{{productStock}}" {{readonly}} />
                </div>

                <div class="row">
                    <label for="productImgUrl" class="col-12 col-m-4">Imagen (URL)</label>
                    <input type="text" class="col-12 col-m-8" name="productImgUrl" id="productImgUrl" value="{{productImgUrl}}" {{readonly}} />
                </div>

                <div class="row">
                    <label for="productStatus" class="col-12 col-m-4">Estado</label>
                    <input type="text" class="col-12 col-m-8" name="productStatus" id="productStatus" value="{{productStatus}}" {{readonly}} />
                </div>

                <div class="row flex-end">
                    <button id="btnCancel">
                        {{if showAction}}
                            Cancelar
                        {{endif showAction}}
                        {{ifnot showAction}}
                            Volver
                        {{endifnot showAction}}
                    </button>
                    &nbsp;
                    {{if showAction}}
                        <button class="primary">Confirmar</button>
                    {{endif showAction}}
                </div>

                {{if error_global}}
                    {{foreach error_global}}
                        <div class="error col-12 col-m-8">{{this}}</div>
                    {{endfor error_global}}
                {{endif error_global}}
            </form>
        </div>
    </div>
</section>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        document.getElementById("btnCancel").addEventListener("click", (e) => {
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Videojuegos-Product");
        });
    });
</script>
