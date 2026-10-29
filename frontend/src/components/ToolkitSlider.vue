<script setup>
import { computed, onMounted, onUnmounted, ref } from 'vue'

const tools = [
  {
    name: 'Visual Studio Code',
    shortName: 'VS Code',
    category: 'MY EVERYDAY WORKSPACE',
    description: 'Where ideas turn into working code. I use VS Code to build, debug and bring each part of a project together.',
    image: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vscode/vscode-original.svg',
    imageAlt: 'Visual Studio Code logo',
    number: '01',
    accent: 'blue',
    tags: ['Code editor', 'Debugging', 'Extensions'],
    projects: [
      { name: 'WeConnect', id: '01' },
      { name: 'Modern Tech', id: '02' },
      { name: 'Lightning News', id: '03' },
    ],
  },
  {
    name: 'Figma',
    shortName: 'Figma',
    category: 'DESIGN & PROTOTYPING',
    description: 'A space to explore layouts, test visual ideas and think through the experience before the code takes shape.',
    image: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/figma/figma-original.svg',
    imageAlt: 'Figma logo',
    number: '02',
    accent: 'coral',
    tags: ['UI ideas', 'Prototypes', 'Design systems'],
    projects: [{ name: 'WeConnect', id: '01' }],
  },
  {
    name: 'HTML5',
    shortName: 'HTML',
    category: 'THE STRUCTURE',
    description: 'Building meaningful page structure with semantic markup that gives content a clear and accessible foundation.',
    image: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/html5/html5-original.svg',
    imageAlt: 'HTML5 logo',
    number: '03',
    accent: 'orange',
    tags: ['Semantic markup', 'Structure', 'Accessibility'],
    projects: [
      { name: 'WeConnect', id: '01' },
      { name: 'Modern Tech', id: '02' },
      { name: 'Lightning News', id: '03' },
    ],
  },
  {
    name: 'CSS3',
    shortName: 'CSS',
    category: 'THE PERSONALITY',
    description: 'Turning structure into polished experiences with responsive layouts, considered details and a little visual warmth.',
    image: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/css3/css3-original.svg',
    imageAlt: 'CSS3 logo',
    number: '04',
    accent: 'sky',
    tags: ['Responsive UI', 'Layout', 'Motion'],
    projects: [
      { name: 'WeConnect', id: '01' },
      { name: 'Modern Tech', id: '02' },
      { name: 'Lightning News', id: '03' },
    ],
  },
  {
    name: 'Python',
    shortName: 'Python',
    category: 'DATA & LOGIC',
    description: 'Exploring data, automating tasks and supporting scraping workflows with a language that keeps problem-solving expressive.',
    image: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/python/python-original.svg',
    imageAlt: 'Python logo',
    number: '05',
    accent: 'gold',
    tags: ['Data extraction', 'Automation', 'Flask'],
    projects: [{ name: 'Lightning News', id: '03' }],
  },
  {
    name: 'JavaScript',
    shortName: 'JavaScript',
    category: 'INTERACTION & LOGIC',
    description: 'Making interfaces respond to people through dynamic behaviour, useful interactions and application logic.',
    image: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/javascript/javascript-original.svg',
    imageAlt: 'JavaScript logo',
    number: '06',
    accent: 'yellow',
    tags: ['Interactivity', 'Application logic', 'DOM'],
    projects: [
      { name: 'WeConnect', id: '01' },
      { name: 'Modern Tech', id: '02' },
      { name: 'Lightning News', id: '03' },
    ],
  },
  {
    name: 'Vue.js',
    shortName: 'Vue.js',
    category: 'BUILDING INTERFACES',
    description: 'Creating reusable components and reactive interfaces that keep a growing application organised and maintainable.',
    image: 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/vuejs/vuejs-original.svg',
    imageAlt: 'Vue.js logo',
    number: '07',
    accent: 'green',
    tags: ['Components', 'Reactivity', 'Single-page apps'],
    projects: [{ name: 'WeConnect', id: '01' }, { name: 'Lightning News', id: '03' }],
  },
]

const activeIndex = ref(0)
const isPaused = ref(false)
const isHovered = ref(false)
const activeTool = computed(() => tools[activeIndex.value])
const motionAllowed = ref(true)
let timer

function goTo(index) {
  activeIndex.value = (index + tools.length) % tools.length
}
function next() {
  goTo(activeIndex.value + 1)
}
function previous() {
  goTo(activeIndex.value - 1)
}
function startTimer() {
  stopTimer()
  if (motionAllowed.value && !isPaused.value && !isHovered.value) {
    timer = window.setInterval(next, 5200)
  }
}
function stopTimer() {
  if (timer) window.clearInterval(timer)
  timer = undefined
}
function togglePause() {
  isPaused.value = !isPaused.value
  startTimer()
}
function handleVisibility() {
  if (document.hidden) stopTimer()
  else startTimer()
}

onMounted(() => {
  motionAllowed.value = !window.matchMedia('(prefers-reduced-motion: reduce)').matches
  startTimer()
  document.addEventListener('visibilitychange', handleVisibility)
})
onUnmounted(() => {
  stopTimer()
  document.removeEventListener('visibilitychange', handleVisibility)
})
</script>

<template>
  <section
    id="toolkit-slider"
    class="toolkit-showcase"
    aria-labelledby="toolkit-slider-title"
    @mouseenter="isHovered = true; stopTimer()"
    @mouseleave="isHovered = false; startTimer()"
    @focusin="stopTimer()"
    @focusout="startTimer()"
  >
    <div class="toolkit-shell">
      <div class="toolkit-heading">
        <p class="toolkit-eyebrow"><span aria-hidden="true">✳</span> THE TOOLS BEHIND THE WORK</p>
        <div class="toolkit-heading-row">
          <div>
            <h2 id="toolkit-slider-title">A toolkit for <em>making things matter.</em></h2>
            <p class="toolkit-intro">A few of the tools and technologies I reach for to turn curious ideas into useful, thoughtful experiences.</p>
          </div>
          <div class="toolkit-counter" aria-live="polite" aria-atomic="true">
            <span>{{ activeTool.number }}</span><i></i>{{ String(tools.length).padStart(2, '0') }}
          </div>
        </div>
      </div>

      <div class="toolkit-stage" aria-roledescription="carousel" aria-label="Development toolkit">
        <div class="toolkit-backdrop-orbit orbit-one"></div>
        <div class="toolkit-backdrop-orbit orbit-two"></div>
        <div class="toolkit-stage-label"><span>TOOLKIT / 2026</span><span>DESIGN · CODE · ITERATE</span></div>

        <Transition name="tool-fade" mode="out-in">
          <article :key="activeTool.name" class="toolkit-feature" :class="'accent-' + activeTool.accent" aria-live="polite">
            <div class="toolkit-art">
              <div class="toolkit-art-ring ring-a"></div>
              <div class="toolkit-art-ring ring-b"></div>
              <span class="toolkit-art-spark spark-a" aria-hidden="true">✳</span>
              <span class="toolkit-art-spark spark-b" aria-hidden="true">✦</span>
              <div class="toolkit-logo-card">
                <img :src="activeTool.image" :alt="activeTool.imageAlt" />
              </div>
              <span class="toolkit-art-index">{{ activeTool.number }} / 07</span>
            </div>
            <div class="toolkit-feature-copy">
              <p class="toolkit-category">{{ activeTool.category }}</p>
              <h3>{{ activeTool.name }}</h3>
              <p class="toolkit-description">{{ activeTool.description }}</p>
              <div class="toolkit-tags">
                <span v-for="tag in activeTool.tags" :key="tag">{{ tag }}</span>
              </div>
              <div v-if="activeTool.projects?.length" class="toolkit-used-in" aria-label="Projects using this tool">
                <span>USED IN</span>
                <a v-for="project in activeTool.projects" :key="project.id" :href="'#project-' + project.id">{{ project.name }} <span aria-hidden="true">↗</span></a>
              </div>
              <div class="toolkit-feature-bottom">
                <span class="toolkit-signature">CURIOUS BY NATURE <b>♡</b></span>
                <span class="toolkit-active-name">CURRENT TOOL <strong>{{ activeTool.shortName }}</strong></span>
              </div>
            </div>
          </article>
        </Transition>

        <div class="toolkit-bottom-bar">
          <div class="toolkit-progress" role="group" aria-label="Choose a toolkit item">
            <button
              v-for="(tool, index) in tools"
              :key="tool.name"
              type="button"
              class="toolkit-progress-item"
              :class="{ 'is-active': activeIndex === index }"
              :aria-label="'Show ' + tool.name"
              :aria-pressed="activeIndex === index"
              @click="goTo(index)"
            >
              <span class="toolkit-progress-number">{{ tool.number }}</span>
              <span class="toolkit-progress-name">{{ tool.shortName }}</span>
            </button>
          </div>
          <div class="toolkit-controls">
            <button class="toolkit-control" type="button" aria-label="Previous tool" @click="previous">←</button>
            <button class="toolkit-control" type="button" aria-label="Next tool" @click="next">→</button>
            <button class="toolkit-pause" type="button" :aria-label="isPaused ? 'Resume automatic slides' : 'Pause automatic slides'" @click="togglePause">{{ isPaused ? 'PLAY' : 'PAUSE' }} <span aria-hidden="true">{{ isPaused ? '▶' : 'Ⅱ' }}</span></button>
          </div>
        </div>
      </div>
      <p class="toolkit-footnote"><span aria-hidden="true">↗</span> A growing toolkit — always learning, testing and finding better ways to build.</p>
    </div>
  </section>
</template>

<style scoped>
.toolkit-showcase {
  --toolkit-ink: #302620;
  --toolkit-muted: #776a60;
  --toolkit-paper: #f5f1eb;
  --toolkit-rose: #b9a899;
  padding: clamp(4rem, 8vw, 7.5rem) 0;
  color: var(--toolkit-ink);
  background: var(--toolkit-paper);
  overflow: hidden;
}
.toolkit-shell { width: min(1120px, calc(100% - 3rem)); margin: 0 auto; }
.toolkit-eyebrow { display: flex; align-items: center; gap: .65rem; margin: 0 0 1.25rem; color: var(--toolkit-muted); font-size: .7rem; font-weight: 800; letter-spacing: .16em; }
.toolkit-eyebrow span { color: #612a22; font-size: 1.1rem; }
.toolkit-heading-row { display: flex; justify-content: space-between; align-items: end; gap: 2rem; margin-bottom: 2.25rem; }
.toolkit-heading h2 { max-width: 750px; margin: 0; font-size: clamp(2.2rem, 5.4vw, 4.3rem); line-height: 1.04; letter-spacing: -.055em; font-weight: 650; }
.toolkit-heading h2 em { color: #612a22; font-family: Georgia, 'Times New Roman', serif; font-weight: 400; }
.toolkit-intro { max-width: 590px; margin: 1.1rem 0 0; color: var(--toolkit-muted); line-height: 1.8; font-size: .96rem; }
.toolkit-counter { display: flex; align-items: center; gap: .6rem; flex-shrink: 0; padding-bottom: .45rem; color: #948c7a; font-size: .8rem; letter-spacing: .12em; }
.toolkit-counter span { color: var(--toolkit-ink); font-size: 1.4rem; font-weight: 750; }
.toolkit-counter i { width: 38px; height: 1px; background: #d7cbc0; }
.toolkit-stage { position: relative; isolation: isolate; padding: 1.5rem clamp(1rem, 4vw, 3rem) 1.1rem; overflow: hidden; border: 1px solid rgba(98, 64, 49, .11); border-radius: 1.8rem; background: linear-gradient(130deg, #e9e1d8 0%, #f5f1eb 48%, #d7cbc0 100%); box-shadow: 0 24px 70px rgba(74, 43, 32, .08); }
.toolkit-stage-label { position: relative; z-index: 1; display: flex; justify-content: space-between; gap: 1rem; color: #9c8075; font-size: .62rem; font-weight: 800; letter-spacing: .13em; }
.toolkit-backdrop-orbit { position: absolute; z-index: -1; border: 1px solid rgba(188, 132, 142, .2); border-radius: 50%; pointer-events: none; }
.orbit-one { width: 520px; height: 520px; top: 4%; left: 11%; }
.orbit-two { width: 720px; height: 720px; top: -7%; left: 2%; }
.toolkit-feature { position: relative; display: grid; grid-template-columns: minmax(260px, .95fr) minmax(0, 1.05fr); align-items: center; gap: clamp(1.5rem, 5vw, 5rem); min-height: 350px; padding: clamp(1rem, 4vw, 3.25rem) 0 2rem; }
.toolkit-art { position: relative; display: grid; min-height: 280px; place-items: center; }
.toolkit-logo-card { position: relative; z-index: 1; display: grid; width: clamp(155px, 21vw, 245px); aspect-ratio: 1; place-items: center; border: 1px solid rgba(255,255,255,.75); border-radius: 2.5rem; background: rgba(255, 252, 249, .8); box-shadow: 0 25px 60px rgba(83, 53, 44, .14), inset 0 1px 0 #fff; transform: rotate(-5deg); }
.toolkit-logo-card img { display: block; width: 52%; height: 52%; object-fit: contain; filter: drop-shadow(0 12px 12px rgba(65, 42, 34, .09)); }
.toolkit-art-ring { position: absolute; width: 285px; max-width: 90%; aspect-ratio: 1; border: 1px dashed rgba(177, 120, 132, .42); border-radius: 50%; animation: toolkit-spin 28s linear infinite; }
.ring-b { width: 340px; border-style: solid; border-color: rgba(255,255,255,.7); animation-direction: reverse; animation-duration: 36s; }
.toolkit-art-spark { position: absolute; z-index: 2; color: #612a22; font-size: 2rem; }
.spark-a { top: 14%; right: 12%; }
.spark-b { bottom: 14%; left: 13%; font-size: 1.5rem; color: #775f4e; }
.toolkit-art-index { position: absolute; bottom: .5rem; right: 1rem; color: #a78d81; font-size: .65rem; font-weight: 800; letter-spacing: .14em; }
.toolkit-feature-copy { position: relative; z-index: 1; }
.toolkit-category { margin: 0 0 .8rem; color: #775f4e; font-size: .68rem; font-weight: 850; letter-spacing: .15em; }
.toolkit-feature-copy h3 { margin: 0; font-size: clamp(2rem, 4vw, 3.45rem); line-height: 1.06; letter-spacing: -.05em; }
.toolkit-description { max-width: 430px; margin: 1.2rem 0 1.4rem; color: #776a60; font-size: .94rem; line-height: 1.85; }
.toolkit-tags { display: flex; flex-wrap: wrap; gap: .5rem; }
.toolkit-tags span { padding: .5rem .75rem; border: 1px solid rgba(108, 72, 57, .13); border-radius: 99px; color: #725a51; background: rgba(255,255,255,.45); font-size: .72rem; }
.toolkit-used-in { display: flex; flex-wrap: wrap; align-items: center; gap: .5rem; margin-top: 1.15rem; }
.toolkit-used-in > span { color: #a0877b; font-size: .6rem; font-weight: 850; letter-spacing: .14em; }
.toolkit-used-in a { display: inline-flex; align-items: center; gap: .3rem; padding: .4rem .65rem; border: 1px solid rgba(108, 72, 57, .16); border-radius: 99px; color: #612a22; background: rgba(255,255,255,.5); font-size: .72rem; font-weight: 700; text-decoration: none; transition: border-color .2s ease, background .2s ease, transform .2s ease; }
.toolkit-used-in a:hover, .toolkit-used-in a:focus-visible { border-color: #612a22; background: #f5f1eb; transform: translateY(-1px); }
.toolkit-used-in a:focus-visible { outline: 2px solid #612a22; outline-offset: 3px; }
.toolkit-feature-bottom { display: flex; justify-content: space-between; align-items: center; gap: 1rem; margin-top: 2.4rem; padding-top: 1rem; border-top: 1px solid rgba(108, 72, 57, .13); }
.toolkit-signature { color: #a0877b; font-size: .61rem; font-weight: 800; letter-spacing: .13em; }
.toolkit-signature b { padding-left: .3rem; color: #a65322; font-size: .9rem; }
.toolkit-active-name { display: flex; align-items: center; gap: .5rem; color: #a0877b; font-size: .58rem; letter-spacing: .12em; }
.toolkit-active-name strong { color: #302620; font-size: .7rem; letter-spacing: 0; }
.toolkit-bottom-bar { display: flex; justify-content: space-between; align-items: center; gap: 1rem; padding-top: 1.2rem; border-top: 1px solid rgba(108, 72, 57, .12); }
.toolkit-progress { display: flex; flex: 1; gap: clamp(.35rem, 1.4vw, 1.2rem); }
.toolkit-progress-item { display: flex; flex-direction: column; align-items: flex-start; gap: .5rem; min-width: 0; padding: .35rem .2rem .5rem; border: 0; border-bottom: 2px solid transparent; color: #948c7a; background: transparent; cursor: pointer; text-align: left; transition: color .2s ease, border-color .2s ease; }
.toolkit-progress-item.is-active { border-color: #612a22; color: #302620; }
.toolkit-progress-number { font-size: .6rem; font-weight: 800; letter-spacing: .1em; }
.toolkit-progress-name { font-size: .76rem; font-weight: 700; }
.toolkit-controls { display: flex; align-items: center; gap: .5rem; }
.toolkit-control { display: grid; width: 42px; height: 42px; place-items: center; border: 1px solid rgba(108, 72, 57, .18); border-radius: 50%; color: #302620; background: rgba(255,255,255,.58); font-size: 1.2rem; cursor: pointer; transition: background .2s ease, transform .2s ease; }
.toolkit-control:hover { background: #fff; transform: translateY(-2px); }
.toolkit-pause { display: flex; align-items: center; gap: .55rem; margin-left: .25rem; padding: .7rem .2rem .7rem .65rem; border: 0; color: #776a60; background: transparent; font-size: .63rem; font-weight: 800; letter-spacing: .12em; cursor: pointer; }
.toolkit-pause span { color: #a65322; font-size: .8rem; }
.toolkit-footnote { display: flex; align-items: center; justify-content: center; gap: .6rem; margin: 1.35rem 0 0; color: #776a60; font-size: .72rem; line-height: 1.7; text-align: center; }
.toolkit-footnote span { color: #a65322; font-size: 1rem; }
.tool-fade-enter-active, .tool-fade-leave-active { transition: opacity .24s ease, transform .24s ease; }
.tool-fade-enter-from { opacity: 0; transform: translateY(8px); }
.tool-fade-leave-to { opacity: 0; transform: translateY(-8px); }
.accent-blue .toolkit-category { color: #6684ac; }
.accent-coral .toolkit-category { color: #bf7d85; }
.accent-orange .toolkit-category { color: #775f4e; }
.accent-sky .toolkit-category { color: #775f4e; }
.accent-gold .toolkit-category { color: #775f4e; }
.accent-yellow .toolkit-category { color: #775f4e; }
.accent-green .toolkit-category { color: #775f4e; }
@keyframes toolkit-spin { to { transform: rotate(360deg); } }
.theme-dark .toolkit-showcase { --toolkit-ink: #f5f1eb; --toolkit-muted: #c7b8aa; --toolkit-paper: #211a16; color: var(--toolkit-ink); background: #211a16; }
.theme-dark .toolkit-heading h2 em { color: #c17a68; }
.theme-dark .toolkit-counter span { color: #f5f1eb; }
.theme-dark .toolkit-stage { border-color: rgba(245, 220, 208, .12); background: linear-gradient(130deg, #302620 0%, #302620 48%, #3a302a 100%); box-shadow: 0 24px 70px rgba(0,0,0,.14); }
.theme-dark .toolkit-stage-label, .theme-dark .toolkit-art-index, .theme-dark .toolkit-signature, .theme-dark .toolkit-active-name { color: #c1a398; }
.theme-dark .toolkit-counter i, .theme-dark .toolkit-feature-bottom, .theme-dark .toolkit-bottom-bar { border-color: rgba(245,220,208,.14); }
.theme-dark .toolkit-counter i { background: #5c463b; }
.theme-dark .toolkit-logo-card { border-color: rgba(255,255,255,.12); background: #f5f1eb; }
.theme-dark .toolkit-description, .theme-dark .toolkit-tags span { color: #c7b8aa; }
.theme-dark .toolkit-tags span { border-color: rgba(245,220,208,.15); background: rgba(38,21,13,.36); }
.theme-dark .toolkit-active-name strong, .theme-dark .toolkit-feature-copy h3 { color: #f5f1eb; }
.theme-dark .toolkit-progress-item { color: #b99d91; }
.theme-dark .toolkit-progress-item.is-active { color: #f5f1eb; }
.theme-dark .toolkit-control { border-color: rgba(245,220,208,.2); color: #f5f1eb; background: rgba(38,21,13,.5); }
.theme-dark .toolkit-control:hover { background: #3a302a; }
.theme-dark .toolkit-pause, .theme-dark .toolkit-footnote { color: #c1a398; }
@media (max-width: 760px) {
  .toolkit-shell { width: min(100% - 1.5rem, 620px); }
  .toolkit-heading-row { align-items: start; }
  .toolkit-heading h2 { font-size: clamp(2.1rem, 8vw, 3.3rem); }
  .toolkit-counter { padding-top: .4rem; }
  .toolkit-feature { grid-template-columns: 1fr; gap: .6rem; padding: 1.3rem 0 1.7rem; }
  .toolkit-art { min-height: 245px; }
  .toolkit-logo-card { width: 175px; border-radius: 2rem; }
  .toolkit-art-ring { width: 230px; }
  .ring-b { width: 280px; }
  .toolkit-art-index { right: 5%; bottom: 0; }
  .toolkit-feature-copy h3 { font-size: 2.5rem; }
  .toolkit-feature-bottom { margin-top: 1.6rem; }
  .toolkit-progress { overflow-x: auto; gap: .8rem; scrollbar-width: thin; }
  .toolkit-progress-item { flex: 0 0 auto; }
  .toolkit-progress-name { font-size: .7rem; }
  .toolkit-bottom-bar { align-items: stretch; flex-direction: column; }
  .toolkit-controls { justify-content: flex-end; }
  .toolkit-pause { margin-left: auto; }
}
@media (max-width: 440px) {
  .toolkit-showcase { padding: 3.5rem 0; }
  .toolkit-shell { width: calc(100% - 1.1rem); }
  .toolkit-heading-row { gap: .6rem; }
  .toolkit-heading h2 { font-size: 2.1rem; }
  .toolkit-counter { gap: .35rem; font-size: .68rem; }
  .toolkit-counter span { font-size: 1.1rem; }
  .toolkit-counter i { width: 18px; }
  .toolkit-stage { padding: 1.1rem .85rem .8rem; border-radius: 1.2rem; }
  .toolkit-stage-label { font-size: .52rem; }
  .toolkit-art { min-height: 220px; }
  .toolkit-logo-card { width: 150px; border-radius: 1.6rem; }
  .toolkit-art-ring { width: 205px; }
  .ring-b { width: 245px; }
  .toolkit-feature-copy h3 { font-size: 2.2rem; }
  .toolkit-description { font-size: .88rem; }
  .toolkit-feature-bottom { align-items: flex-start; flex-direction: column; gap: .75rem; }
  .toolkit-progress-name { font-size: .65rem; }
  .toolkit-control { width: 38px; height: 38px; }
}
@media (prefers-reduced-motion: reduce) {
  .toolkit-art-ring { animation: none; }
  .tool-fade-enter-active, .tool-fade-leave-active, .toolkit-progress-item, .toolkit-control { transition: none; }
}

/* Keep the toolkit in sync with the site's espresso-brown dark theme. */
:global(.theme-dark) .toolkit-showcase {
  --toolkit-ink: #f5f1eb;
  --toolkit-muted: #c7b8aa;
  --toolkit-paper: #26150d;
  --toolkit-rose: #b9a899;
  background: #26150d;
  color: #f5f1eb;
}
:global(.theme-dark) .toolkit-stage {
  border-color: rgba(233, 174, 188, .22);
  background: linear-gradient(130deg, #382019 0%, #312019 48%, #3a302a 100%);
  box-shadow: 0 24px 70px rgba(0, 0, 0, .18);
}
:global(.theme-dark) .toolkit-stage-label,
:global(.theme-dark) .toolkit-counter,
:global(.theme-dark) .toolkit-art-index,
:global(.theme-dark) .toolkit-signature,
:global(.theme-dark) .toolkit-active-name { color: #c7b8aa; }
:global(.theme-dark) .toolkit-counter span,
:global(.theme-dark) .toolkit-active-name strong { color: #f5f1eb; }
:global(.theme-dark) .toolkit-logo-card {
  border-color: rgba(255, 235, 226, .16);
  background: rgba(255, 245, 239, .94);
  box-shadow: 0 25px 60px rgba(0, 0, 0, .22), inset 0 1px 0 #fff;
}
:global(.theme-dark) .toolkit-description { color: #c7b8aa; }
:global(.theme-dark) .toolkit-used-in > span { color: #c7b8aa; }
:global(.theme-dark) .toolkit-used-in a { border-color: rgba(233, 174, 188, .3); color: #f5f1eb; background: rgba(38, 21, 13, .6); }
:global(.theme-dark) .toolkit-used-in a:hover, :global(.theme-dark) .toolkit-used-in a:focus-visible { border-color: #b9a899; background: #302620; }
:global(.theme-dark) .toolkit-tags span {
  border-color: rgba(233, 174, 188, .24);
  color: #f5f1eb;
  background: rgba(38, 21, 13, .42);
}
:global(.theme-dark) .toolkit-feature-bottom,
:global(.theme-dark) .toolkit-bottom-bar { border-color: rgba(233, 174, 188, .2); }
:global(.theme-dark) .toolkit-progress-item { color: #c7b8aa; }
:global(.theme-dark) .toolkit-progress-item.is-active,
:global(.theme-dark) .toolkit-progress-item:hover { color: #f5f1eb; border-color: #b9a899; }
:global(.theme-dark) .toolkit-control,
:global(.theme-dark) .toolkit-pause { border-color: rgba(233, 174, 188, .35); color: #f5f1eb; background: rgba(38, 21, 13, .35); }
:global(.theme-dark) .toolkit-control:hover,
:global(.theme-dark) .toolkit-pause:hover { background: rgba(233, 174, 188, .14); }
:global(.theme-dark) .toolkit-footnote { color: #c7b8aa; }
@media (max-width: 640px) {
  .toolkit-shell { width: min(100% - 2rem, 1120px); }
  .toolkit-heading-row { align-items: flex-start; gap: 1rem; }
  .toolkit-counter { padding-top: .25rem; }
  .toolkit-stage-label span:last-child { text-align: right; }
  .toolkit-feature-bottom { align-items: flex-start; flex-direction: column; gap: .75rem; }
  .toolkit-bottom-bar { align-items: stretch; flex-direction: column; }
  .toolkit-progress { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: .35rem .65rem; }
  .toolkit-progress-item { padding: .45rem .2rem; }
  .toolkit-progress-name { font-size: .65rem; }
  .toolkit-controls { justify-content: flex-end; }
}
</style>
