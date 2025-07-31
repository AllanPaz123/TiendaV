<link rel="stylesheet" href="public/css/styleR.css" />

<section class="container-l">
  <section class="checkout-header">
    <h2>✅ Orden Aceptada</h2>
  </section>

  <section class="grid">
    <div class="row success-row">
      <div class="col-12">
        <div class="success-box">
          <p><strong>¡Gracias por tu compra!</strong></p>
          <p>Tu orden ha sido procesada exitosamente a través de PayPal.</p>
          <p>Puedes revisar el detalle completo en tu 
            <a href="index.php?page=Checkout_Historial">historial de compras</a>.
          </p>
        </div>
      </div>
    </div>

    {{if orderjson}}
    <div class="row debug-row">
      <div class="col-12">
        <div class="debug-box">
          <h4>🧾 Detalle de la respuesta PayPal (JSON):</h4>
          <pre style="font-size: 0.9rem; background-color: #f5f5f5; padding: 1rem;">
{{orderjson}}
          </pre>
        </div>
      </div>
    </div>
    {{endif}}

    <div class="row btn-row">
      <div class="col-12 right">
        <a href="index.php" class="btn-return">Volver al Inicio</a>
      </div>
    </div>
  </section>
</section>




