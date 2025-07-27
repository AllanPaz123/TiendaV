<section class="depth-2 px-2 py-2">
    <h2>{{modeDsc}}</h2>
</section>
<section class="grid py-4 px-4 my-4">
    <div class="row">
        <div class="col-12 offset-m-1 col-m-10 offset-l-3 col-l-6">
            <form class="row" action="index.php?page=Videojuegos-Inventario&mode={{mode}}&inventarioid={{inventarioid}}" method="post">
                <div class="row">
                    <label for="inventarioid" class="col-12 col-m-4">ID</label>
                    <input readonly type="text" class="col-12 col-m-8" name="inventarioid" id="inventarioid" value="{{inventarioid}}" />
                    <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
                </div>

                <div class="row">
                    <label for="videojuegocod" class="col-12 col-m-4">Videojuego</label>
                    <select class="col-12 col-m-8" name="videojuegocod" id="videojuegocod" {{readonly}}>
                        <option value="">-- Seleccione un videojuego --</option>
                        {{foreach videojuegos}}
                            <option value="{{videojuegocod}}" {{if ../videojuegocod == videojuegocod}}selected{{endif}}>
                                {{titulo}}
                            </option>
                        {{endfor videojuegos}}
                    </select>
                    {{if error_videojuegocod}} 
                        <span class="error col-12 col-m-8">{{error_videojuegocod}}</span>
                    {{endif error_videojuegocod}}
                </div>

                <div class="row">
                    <label for="stock" class="col-12 col-m-4">Stock</label>
                    <input type="number" class="col-12 col-m-8" name="stock" id="stock" value="{{stock}}" {{readonly}} />
                    {{if error_stock}} 
                        <span class="error col-12 col-m-8">{{error_stock}}</span>
                    {{endif error_stock}}
                </div>

                <div class="row">
                    <label for="ubicacion" class="col-12 col-m-4">Ubicación</label>
                    <input type="text" class="col-12 col-m-8" name="ubicacion" id="ubicacion" value="{{ubicacion}}" {{readonly}} />
                    {{if error_ubicacion}} 
                        <span class="error col-12 col-m-8">{{error_ubicacion}}</span>
                    {{endif error_ubicacion}}
                </div>

                <div class="row flex-end">
                    <button id="btnCancel">
                        {{if showAction}}Cancelar{{endif}}
                        {{ifnot showAction}}Volver{{endifnot showAction}}
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
            window.location.assign("index.php?page=Videojuegos-Inventario");
        });
    });
</script>
