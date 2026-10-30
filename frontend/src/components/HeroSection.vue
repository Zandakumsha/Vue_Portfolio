<template>
  <section id="home" class="hero page-wrap">
    <div class="hero-copy">
      <p class="eyebrow"><span class="hero-eyebrow-dash" aria-hidden="true">—</span> HELLO, I'M</p>
      <p class="hero-location">Cape Town, Western Cape, South Africa — where I'm based.</p>
      <h1><span class="hero-name">Zanda.</span><br /><em>Web developer.</em></h1>
      <p class="hero-description">
        I turn ideas into thoughtful web experiences, building across the stack to solve real-world problems.
      </p>
      <div class="hero-actions">
        <a class="button-primary" href="#work">Explore my work <span>↗</span></a>
        <a class="button-primary cv-download-button" href="/Zanda-CV.pdf" download="Zanda-Kumsha-CV.pdf">Download CV <span aria-hidden="true">↓</span></a>
        <a class="text-link" href="https://github.com/Zandakumsha" target="_blank" rel="noopener noreferrer">Visit GitHub ↗</a>
        <a class="text-link" href="#journey">Explore my journey ↓</a>
        <a class="text-link" href="#contact">Let's connect ↓</a>
      </div>
      <p class="little-note"><span>✳</span> VUE.JS&nbsp; · &nbsp;NODE.JS&nbsp; · &nbsp;PYTHON&nbsp; · &nbsp;MYSQL</p>
    </div>

    <div class="hero-art hero-animation-stage" role="img" aria-label="Animated warm-brown laptop with code typing on the screen beside a steaming cup of coffee">
      <div class="animation-halo animation-halo-back"></div>
      <div class="animation-halo animation-halo-front"></div>
      <div class="animation-label animation-label-top"><span class="animation-live-dot"></span> CURRENTLY CREATING</div>

      <svg class="hero-laptop-animation" viewBox="0 0 460 350" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
        <defs>
          <linearGradient id="laptopLid" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stop-color="#775f4e" />
            <stop offset="100%" stop-color="#302620" />
          </linearGradient>
          <linearGradient id="laptopBase" x1="0" y1="0" x2="0" y2="1">
            <stop offset="0%" stop-color="#e9e1d8" />
            <stop offset="100%" stop-color="#b9a899" />
          </linearGradient>
        </defs>
        <ellipse class="laptop-shadow" cx="222" cy="294" rx="160" ry="19" />
        <g class="laptop-float">
          <rect class="laptop-lid" x="77" y="47" width="294" height="213" rx="15" fill="url(#laptopLid)" />
          <rect class="laptop-screen" x="89" y="59" width="270" height="187" rx="7" />
          <circle cx="224" cy="53" r="2" fill="#948c7a" />
          <g class="laptop-editor">
            <text x="106" y="80" class="editor-caption">zanda.dev / portfolio.js</text>
            <path class="editor-line editor-line-1" d="M109 105 H173" />
            <path class="editor-line editor-line-2" d="M125 123 H220" />
            <path class="editor-line editor-line-3" d="M125 141 H193" />
            <path class="editor-line editor-line-4" d="M143 159 H246" />
            <path class="editor-line editor-line-5" d="M143 177 H206" />
            <path class="editor-line editor-line-6" d="M125 195 H180" />
            <path class="editor-line editor-line-7" d="M109 213 H162" />
            <rect class="typing-caret" x="167" y="207" width="2.5" height="9" rx="1" />
            <circle cx="338" cy="72" r="3" fill="#b9a899" />
            <circle cx="326" cy="72" r="3" fill="#b9a899" />
            <circle cx="314" cy="72" r="3" fill="#e9e1d8" />
          </g>
          <path class="laptop-base" d="M62 260 H386 L414 281 Q416 287 405 290 H45 Q35 287 39 281 Z" fill="url(#laptopBase)" />
          <path class="laptop-base-highlight" d="M62 260 H386 L398 270 H51 Z" />
          <rect class="laptop-trackpad" x="188" y="269" width="71" height="7" rx="3.5" />
          <path class="laptop-front-edge" d="M44 286 Q40 289 49 291 H402 Q412 289 405 286" />
        </g>
        <g class="floating-code-symbol" transform="translate(53 113)">
          <circle r="23" fill="#f5f1eb" stroke="#d7cbc0" stroke-width="1.5" />
          <path d="M-5 -7 L-12 0 L-5 7 M5 -7 L12 0 L5 7" fill="none" stroke="#612a22" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
        </g>
        <g class="floating-sparkle" transform="translate(383 125)" fill="#948c7a">
          <path d="M0 -12 L3 -3 L12 0 L3 3 L0 12 L-3 3 L-12 0 L-3 -3 Z" />
        </g>
        <g class="floating-sparkle floating-sparkle-small" transform="translate(96 229)" fill="#775f4e">
          <path d="M0 -7 L2 -2 L7 0 L2 2 L0 7 L-2 2 L-7 0 L-2 -2 Z" />
        </g>
      </svg>

      <div class="animated-coffee" aria-hidden="true">
        <svg viewBox="0 0 120 130" xmlns="http://www.w3.org/2000/svg">
          <ellipse cx="54" cy="113" rx="40" ry="7" fill="#302620" opacity=".10" />
          <ellipse cx="54" cy="103" rx="42" ry="10" fill="#b9a899" stroke="#948c7a" stroke-width="1.5" />
          <ellipse cx="54" cy="101" rx="30" ry="6" fill="#f5f1eb" stroke="#948c7a" stroke-width="1.5" />
          <path d="M29 62 H78 V91 Q77 101 65 102 H43 Q30 100 29 89 Z" fill="#f5f1eb" stroke="#aeb99f" stroke-width="1.7" />
          <path d="M78 69 H85 Q99 69 96 82 Q94 92 78 90" fill="none" stroke="#aeb99f" stroke-width="6" stroke-linecap="round" />
          <path d="M78 72 H84 Q91 72 89 81 Q88 86 78 86" fill="none" stroke="#f5f1eb" stroke-width="3" stroke-linecap="round" />
          <ellipse cx="54" cy="63" rx="25" ry="7" fill="#775f4e" stroke="#aeb99f" stroke-width="1.5" />
          <ellipse cx="54" cy="63" rx="19" ry="4.5" fill="#302620" />
          <g class="coffee-steam">
            <path class="steam-wisp steam-wisp-one" d="M42 50 C32 40 48 34 41 23" />
            <path class="steam-wisp steam-wisp-two" d="M55 48 C66 37 49 31 59 17" />
            <path class="steam-wisp steam-wisp-three" d="M68 51 C78 42 67 33 75 27" />
          </g>
        </svg>
      </div>

      <div class="animation-note-card">
        <span class="animation-note-icon">✳</span>
        <span><strong>Made with intention</strong><small>one line at a time</small></span>
      </div>
      <div class="animation-label animation-label-bottom">DESIGN <span>·</span> CODE <span>·</span> COFFEE</div>
    </div>
    <div class="scroll-cue"><span>SCROLL TO DISCOVER</span><i></i><span>01 — 05</span></div>
  </section>
</template>
