<section class="depth-2 px-2 py-2">
    <h2>{{modeDsc}}</h2>
</section>
<section class="grid py-4 px-4 my-4">
    <div class="row">
        <div class="col-12 offset-m-1 col-m-10 offset-l-3 col-l-6">
            <form class="row" action="index.php?page=Videojuegos-Videojuego&mode={{mode}}&videojuegocod={{videojuegocod}}" method="post">
                <div class="row">
                    <label for="videojuegocod" class="col-12 col-m-4">Código</label>
                    <input readonly type="text" class="col-12 col-m-8" name="videojuegocod" id="videojuegocod" value="{{videojuegocod}}" />
                    <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
                </div>

                <div class="row">
                    <label for="titulo" class="col-12 col-m-4">Título</label>
                    <input type="text" class="col-12 col-m-8" name="titulo" id="titulo" value="{{titulo}}" {{readonly}} />
                    {{if error_titulo}} 
                        <span class="error col-12 col-m-8">{{error_titulo}}</span>
                    {{endif error_titulo}}
                </div>

                <div class="row">
                    <label for="descripcion" class="col-12 col-m-4">Descripción</label>
                    <textarea class="col-12 col-m-8" name="descripcion" id="descripcion" {{readonly}}>{{descripcion}}</textarea>
                </div>

                <div class="row">
                    <label for="precio" class="col-12 col-m-4">Precio</label>
                    <input type="number" step="0.01" class="col-12 col-m-8" name="precio" id="precio" value="{{precio}}" {{readonly}} />
                    {{if error_precio}} 
                        <span class="error col-12 col-m-8">{{error_precio}}</span>
                    {{endif error_precio}}
                </div>

                <div class="row">
                    <label for="imagen" class="col-12 col-m-4">Imagen (URL)</label>
                    <input type="text" class="col-12 col-m-8" name="imagen" id="imagen" value="{{imagen}}" {{readonly}} />
                </div>

                <div class="row">
                    <label for="archivo_descarga" class="col-12 col-m-4">Archivo Descarga (URL)</label>
                    <input type="text" class="col-12 col-m-8" name="archivo_descarga" id="archivo_descarga" value="{{archivo_descarga}}" {{readonly}} />
                </div>

                <div class="row">
                    <label for="formato" class="col-12 col-m-4">Formato</label>
                    <select class="col-12 col-m-8" name="formato" id="formato" {{readonly}}>
                        <option value="digital" {{formato_digital}}>Digital</option>
                        <option value="fisico" {{formato_fisico}}>Físico</option>
                        <option value="ambos" {{formato_ambos}}>Ambos</option>
                    </select>
                    {{if error_formato}} 
                        <span class="error col-12 col-m-8">{{error_formato}}</span>
                    {{endif error_formato}}
                </div>

                <div class="row">
                    <label for="videojuegoest" class="col-12 col-m-4">Estado</label>
                    <input type="text" class="col-12 col-m-8" name="videojuegoest" id="videojuegoest" value="{{videojuegoest}}" {{readonly}} />
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
            window.location.assign("index.php?page=Videojuegos-Videojuego");
        });
    });
</script>
