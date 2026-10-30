<template>
  <section id="about" class="page-wrap content-section about-section">
    <p class="section-kicker"><span>01</span> A NOTE ABOUT ME</p>
    <div class="about-grid">
      <div class="about-visual-panel about-photo-panel">
        <span class="portrait-sparkle sparkle-one" aria-hidden="true">✳</span>
        <span class="portrait-sparkle sparkle-two" aria-hidden="true">✦</span>
        <span class="portrait-orbit orbit-one" aria-hidden="true"></span>
        <span class="portrait-orbit orbit-two" aria-hidden="true"></span>
        <div class="portrait-frame">
          <img
            class="about-portrait"
            src="/Screenshot%202026-06-05%20184643.png"
            alt="Portrait of Zanda"
            loading="lazy"
          />
        </div>
        <span class="portrait-sticker" aria-hidden="true">IN MY<br />BUILDING ERA</span>
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
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 500px;
  padding: 2.5rem 2rem 5.5rem;
  overflow: hidden;
  border: 1px solid rgb(166 83 34 / 30%);
  border-radius: 46% 46% 24px 24px;
  background:
    radial-gradient(circle at 15% 18%, rgb(255 248 237 / 92%) 0 2px, transparent 3px),
    radial-gradient(circle at 86% 28%, rgb(166 83 34 / 18%) 0 3px, transparent 4px),
    linear-gradient(145deg, var(--soft), var(--paper));
  box-shadow: 0 24px 60px rgb(48 38 32 / 14%);
}

.portrait-frame {
  position: relative;
  z-index: 1;
  width: min(100%, 340px);
  height: 390px;
  overflow: hidden;
  border: 7px solid var(--paper);
  border-radius: 48% 48% 18px 18px;
  background: var(--soft);
  box-shadow: 0 16px 34px rgb(48 38 32 / 20%), 0 0 0 1px rgb(166 83 34 / 25%);
}

.about-portrait {
  display: block;
  width: 100%;
  height: 100%;
  max-width: none;
  object-fit: cover;
  object-position: center top;
  transition: transform 450ms ease;
}

.about-photo-panel:hover .about-portrait {
  transform: scale(1.01);
}

.portrait-sparkle {
  position: absolute;
  z-index: 2;
  color: var(--rose);
  line-height: 1;
  pointer-events: none;
}

.sparkle-one {
  top: 16%;
  left: 10%;
  font-size: 2.2rem;
  animation: portrait-twinkle 3.2s ease-in-out infinite;
}

.sparkle-two {
  top: 30%;
  right: 10%;
  color: var(--ink);
  font-size: 1.6rem;
  animation: portrait-twinkle 3.8s ease-in-out infinite reverse;
}

.portrait-orbit {
  position: absolute;
  z-index: 0;
  width: 78px;
  height: 78px;
  border: 1px solid rgb(166 83 34 / 42%);
  border-radius: 50%;
  pointer-events: none;
}

.orbit-one {
  top: 13%;
  right: 14%;
}

.orbit-two {
  bottom: 22%;
  left: 8%;
  width: 42px;
  height: 42px;
  border-style: dashed;
}

.portrait-sticker {
  position: absolute;
  z-index: 3;
  right: 5%;
  bottom: 19%;
  display: grid;
  width: 86px;
  height: 86px;
  place-content: center;
  border: 2px solid var(--paper);
  border-radius: 50%;
  background: var(--rose);
  color: var(--paper);
  font-size: 0.61rem;
  font-weight: 800;
  line-height: 1.45;
  letter-spacing: 0.06em;
  text-align: center;
  transform: rotate(10deg);
  box-shadow: 0 8px 20px rgb(48 38 32 / 18%);
}

.about-photo-panel .about-visual-caption {
  z-index: 4;
  right: 0.9rem;
  bottom: 0.9rem;
  left: 0.9rem;
  padding: 0.85rem 0.9rem;
  border: 1px solid rgb(255 248 237 / 28%);
  border-radius: 5px 14px;
  background: rgb(48 38 32 / 84%);
  color: #fff8ed;
  font-size: 0.62rem;
  line-height: 1.5;
  backdrop-filter: blur(8px);
}

@keyframes portrait-twinkle {
  0%, 100% { transform: translateY(0) rotate(0); opacity: 0.75; }
  50% { transform: translateY(-5px) rotate(12deg); opacity: 1; }
}

@media (max-width: 900px) {
  .about-photo-panel {
    min-height: 470px;
  }

  .portrait-frame {
    height: 360px;
  }
}

@media (max-width: 700px) {
  .about-photo-panel {
    min-height: 430px;
    padding: 2.2rem 1rem 5.5rem;
  }

  .portrait-frame {
    width: min(100%, 300px);
    height: 330px;
  }

  .portrait-sticker {
    right: 3%;
    bottom: 20%;
    width: 72px;
    height: 72px;
    font-size: 0.54rem;
  }

  .sparkle-one { left: 5%; font-size: 1.8rem; }
  .sparkle-two { right: 5%; }
  .about-photo-panel .about-visual-caption {
    flex-wrap: wrap;
    justify-content: flex-start;
    gap: 0.35rem 0.8rem;
  }
}

@media (prefers-reduced-motion: reduce) {
  .about-portrait,
  .portrait-sparkle {
    transition: none;
    animation: none;
  }
}
</style>
