<template>
  <div class="sharing-services">
    <div class="navigation">
      <ul>
        <li class="email">
          <a href="#">✉️</a>
        </li>
        <li class="facebook">
          <a href="#">F</a>
        </li>
        <li class="twitter">
          <a href="#">T</a>
        </li>
        <li class="others">
          <a href="#">🔗</a>
        </li>
      </ul>
    </div>
    <div class="services">
      <div class="service">
        <div class="sender">From <span>james@buyapowa.com</span></div>
        <div class="recipient">
          <input placeholder="Email address" type="email">
        </div>
        <div class="message">
          <textarea>
To my good friend,

Please buy the things here:

http://the.things/abc</textarea>
        </div>
        <div class="action">
          <button>Send email</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  export default {}
</script>
