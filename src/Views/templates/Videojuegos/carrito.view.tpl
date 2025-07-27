<section class="depth-2 px-2 py-2">
    <h2>{{modeDsc}}</h2>
</section>
<section class="grid py-4 px-4 my-4">
    <div class="row">
        <div class="col-12 offset-m-1 col-m-10 offset-l-3 col-l-6">
            <form class="row" action="index.php?page=Videojuegos-Carrito&mode={{mode}}&id={{carritoid}}" method="post">
                <div class="row">
                    <label for="carritoid" class="col-12 col-m-4">Id</label>
                    <input readonly type="text" class="col-12 col-m-8" name="carritoid" id="carritoid" value="{{carritoid}}" />
                    <input type="hidden" name="xsrToken" value="{{xsrToken}}" />
                </div>
                <div class="row">
                    <label for="usercod" class="col-12 col-m-4">Código de Usuario</label>
                    <input type="number" class="col-12 col-m-8" name="usercod" id="usercod" value="{{usercod}}" {{readonly}} />
                    {{if error_usercod}} 
                        <span class="error col-12 col-m-8">{{error_usercod}}</span>
                    {{endif error_usercod}}
                </div>
                <div class="row">
                    <label for="videojuegocod" class="col-12 col-m-4">Código de Videojuego</label>
                    <input type="number" class="col-12 col-m-8" name="videojuegocod" id="videojuegocod" value="{{videojuegocod}}" {{readonly}} />
                    {{if error_videojuegocod}} 
                        <span class="error col-12 col-m-8">{{error_videojuegocod}}</span>
                    {{endif error_videojuegocod}}
                </div>
                <div class="row">
                    <label for="cantidad" class="col-12 col-m-4">Cantidad</label>
                    <input type="number" class="col-12 col-m-8" name="cantidad" id="cantidad" value="{{cantidad}}" {{readonly}} />
                    {{if error_cantidad}} 
                        <span class="error col-12 col-m-8">{{error_cantidad}}</span>
                    {{endif error_cantidad}}
                </div>
                <div class="row">
                    <label for="tipo_entrega" class="col-12 col-m-4">Tipo de Entrega</label>
                    <select id="tipo_entrega" name="tipo_entrega" {{if readonly}}readonly disabled{{endif readonly}}>
                        <option value="digital" {{entrega_digital}}>Digital</option>
                        <option value="fisico" {{entrega_fisico}}>Físico</option>
                    </select>
                    {{if error_tipo_entrega}} 
                        <span class="error col-12 col-m-8">{{error_tipo_entrega}}</span>
                    {{endif error_tipo_entrega}}
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
            window.location.assign("index.php?page=Videojuegos-Carritos");
        });
    });
</script>
