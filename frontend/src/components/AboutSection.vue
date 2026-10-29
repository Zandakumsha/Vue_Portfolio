<template>
  <section id="about" class="page-wrap content-section about-section">
    <p class="section-kicker"><span>01</span> A NOTE ABOUT ME</p>
    <div class="about-grid">
      <div class="about-visual-panel about-photo-panel">
        <img
          class="about-portrait"
          src="/Screenshot%202026-06-05%20184643.png"
          alt="Portrait of Zanda"
          loading="lazy"
        />
        <div class="about-visual-caption">
          <span>01 / ALWAYS LEARNING</span>
          <span>MADE WITH CURIOSITY</span>
        </div>
      </div>
      <div class="body-copy about-body-copy">
        <h2 class="about-intro-heading">Curious mind.<br /><em>Builder's mindset.</em></h2>
        <p class="statement">I believe the best digital experiences live where clean engineering meets a little bit of magic.</p>
        <p>I'm Zanda, a developer growing my craft across frontend and backend technologies. I enjoy shaping ideas into useful products, untangling tricky problems and making the details feel just as considered as the big picture.</p>
        <p>My approach is curious, collaborative and people-first. I'm here to keep learning, build with purpose and create technology that makes someone's day a little easier.</p>
        <a class="under-link" href="#contact">Have a project in mind? <span>Let's connect ↗</span></a>
      </div>
    </div>
    <div class="values-row">
      <div class="value-item"><span class="value-icon">✳</span><div><strong>Thoughtful by design</strong><small>Details matter. People matter more.</small></div></div>
      <div class="value-item"><span class="value-icon">♡</span><div><strong>Always evolving</strong><small>Curiosity is part of the process.</small></div></div>
      <div class="value-item"><span class="value-icon">⌘</span><div><strong>Built to be useful</strong><small>Beautiful is better when it works.</small></div></div>
    </div>
  </section>
</template>

<style scoped>
.about-photo-panel {
  position: relative;
  isolation: isolate;
  min-height: 430px;
  border: 1px solid rgb(166 83 34 / 24%);
  background: var(--soft);
  box-shadow: 0 22px 55px rgb(48 38 32 / 14%);
}

.about-portrait {
  position: absolute;
  inset: 0;
  z-index: 0;
  display: block;
  width: 100%;
  height: 100%;
  max-width: none;
  object-fit: cover;
  object-position: center 30%;
  transform: scale(1.001);
  transition: transform 450ms ease;
}

.about-photo-panel:hover .about-portrait {
  transform: scale(1.035);
}

.about-photo-panel .about-visual-caption {
  z-index: 1;
  right: 0.9rem;
  bottom: 0.9rem;
  left: 0.9rem;
  padding: 0.85rem 0.9rem;
  border: 1px solid rgb(255 248 237 / 28%);
  border-radius: 5px 14px;
  background: rgb(48 38 32 / 78%);
  color: #fff8ed;
  font-size: 0.62rem;
  line-height: 1.5;
  backdrop-filter: blur(8px);
}

@media (max-width: 900px) {
  .about-photo-panel {
    min-height: 370px;
  }
}

@media (max-width: 700px) {
  .about-photo-panel {
    min-height: 320px;
    max-height: 430px;
  }

  .about-photo-panel .about-visual-caption {
    flex-wrap: wrap;
    justify-content: flex-start;
    gap: 0.35rem 0.8rem;
  }
}

@media (prefers-reduced-motion: reduce) {
  .about-portrait {
    transition: none;
  }
}
</style>
