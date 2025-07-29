<h1>Mantenimiento de Videojuegos</h1> 
<section class="grid">
  <div class="row">
    <form class="col-12 col-m-8" action="index.php" method="get">
      <div class="flex align-center">
        <div class="col-8 row">
          <input type="hidden" name="page" value="Videojuegos-Products">
          <label class="col-3" for="partialName">Nombre</label>
          <input class="col-9" type="text" name="partialName" id="partialName" value="{{partialName}}" />
          <label class="col-3" for="status">Estado</label>
          <select class="col-9" name="status" id="status">
              <option value="EMP" {{status_EMP}}>Todos</option>
              <option value="ACT" {{status_ACT}}>Activo</option>
              <option value="INA" {{status_INA}}>Inactivo</option>
          </select>
        </div>
        <div class="col-4 align-end">
          <button type="submit">Filtrar</button>
        </div>
      </div>
    </form>
  </div>
</section>

<section class="WWList">
  <table>
    <thead>
      <tr>
        <th>
          {{ifnot OrderByProductId}}
          <a href="index.php?page=Videojuegos-Products&orderBy=productId&orderDescending=0">Id <i class="fas fa-sort"></i></a>
          {{endifnot OrderByProductId}}
          {{if OrderProductIdDesc}}
          <a href="index.php?page=Videojuegos-Products&orderBy=clear&orderDescending=0">Id <i class="fas fa-sort-down"></i></a>
          {{endif OrderProductIdDesc}}
          {{if OrderProductId}}
          <a href="index.php?page=Videojuegos-Products&orderBy=productId&orderDescending=1">Id <i class="fas fa-sort-up"></i></a>
          {{endif OrderProductId}}
        </th>
        <th>Nombre</th>
        <th>Descripción</th>
        <th>Precio</th>
        <th>Stock</th>
        <th>Estado</th>
        <th>Imagen</th>
        <th>
          {{if ~product_INS}}
          <a href="index.php?page=Videojuegos-Product&mode=INS&productId=">Nuevo</a>
          {{endif ~product_INS}}
        </th>
      </tr>
    </thead>
    <tbody>
      {{foreach products}}
      <tr>
        <td>{{productId}}</td>
        <td>{{productName}}</td>
        <td>{{productDescription}}</td>
        <td>L {{productPrice}}</td>
        <td>{{productStock}}</td>
        <td>{{productStatus}}</td>
        <td>
          {{if productImgUrl}}
            <img src="{{productImgUrl}}" alt="img" style="max-height: 80px; max-width: 80px; display: block; margin: 0 auto;" />
            <small style="display: block; word-break: break-all; text-align: center;">{{productImgUrl}}</small>
          {{endif productImgUrl}}
        </td>
        <td>
          {{if ~product_DSP}}
          <a href="index.php?page=Videojuegos-Product&mode=DSP&productId={{productId}}">Ver</a>
          {{endif ~product_DSP}}
          &nbsp;
          {{if ~product_UPD}}
          <a href="index.php?page=Videojuegos-Product&mode=UPD&productId={{productId}}">Editar</a>
          {{endif ~product_UPD}}
          &nbsp;
          {{if ~product_DEL}}
          <a href="index.php?page=Videojuegos-Product&mode=DEL&productId={{productId}}">Eliminar</a>
          {{endif ~product_DEL}}
        </td>
      </tr>
      {{endfor products}}
    </tbody>
  </table>
  {{pagination}}

</section>

<div style="margin-top: 1rem;">
    <a href="index.php" class="btn">← Regresar al inicio</a>
  </div>
</section>