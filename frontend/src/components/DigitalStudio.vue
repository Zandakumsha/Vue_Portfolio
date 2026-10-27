<script setup>
import { computed, ref } from 'vue'

const rooms = [
  { id: 'projects', label: 'Projects', symbol: '▧', eyebrow: 'THE WORKROOM', title: 'Choose a project to explore', description: 'Jump straight into the case studies for the context, contribution and lessons behind each build.' },
  { id: 'credentials', label: 'Milestones', symbol: '✳', eyebrow: 'THE GALLERY', title: 'Progress worth keeping', description: 'A quick route to verified credentials and the milestones that mark my learning journey.' },
  { id: 'toolkit', label: 'Toolkit', symbol: '⌘', eyebrow: 'THE TOOL SHELF', title: 'Tools I’ve put into practice', description: 'Browse the technologies connected to my project work, from interfaces to data and APIs.' },
  { id: 'journal', label: 'Field journal', symbol: '▤', eyebrow: 'THE NOTEBOOK', title: 'Notes from the process', description: 'Open the journal for short reflections on debugging, teamwork and learning by building.' },
]
const activeRoomId = ref('projects')
const activeRoom = computed(() => rooms.find((room) => room.id === activeRoomId.value) || rooms[0])
const pointerX = ref(50)
const pointerY = ref(40)
const spotlightStyle = computed(() => ({
  '--spot-x': pointerX.value + '%',
  '--spot-y': pointerY.value + '%',
}))
function trackPointer(event) {
  const bounds = event.currentTarget.getBoundingClientRect()
  pointerX.value = Math.round(((event.clientX - bounds.left) / bounds.width) * 100)
  pointerY.value = Math.round(((event.clientY - bounds.top) / bounds.height) * 100)
}
function resetPointer() {
  pointerX.value = 50
  pointerY.value = 40
}
function tiltCard(event) {
  const card = event.currentTarget
  const bounds = card.getBoundingClientRect()
  const x = (event.clientX - bounds.left) / bounds.width
  const y = (event.clientY - bounds.top) / bounds.height
  card.style.setProperty('--tilt-x', ((0.5 - y) * 4).toFixed(2) + 'deg')
  card.style.setProperty('--tilt-y', ((x - 0.5) * 5).toFixed(2) + 'deg')
}
function resetCard(event) {
  event.currentTarget.style.setProperty('--tilt-x', '0deg')
  event.currentTarget.style.setProperty('--tilt-y', '0deg')
}
</script>

<template>
  <section id="studio" class="page-wrap content-section digital-studio-section">
    <p class="section-kicker"><span>✳</span> A LITTLE SPACE ON THE INTERNET</p>
    <div class="studio-heading">
      <div>
        <h2>Welcome to my <em>digital studio.</em></h2>
        <p>Four little doors into my work, tools and learning journey. Pick one to explore.</p>
      </div>
      <span class="studio-open-badge"><i aria-hidden="true"></i> OPEN STUDIO <span class="studio-live-spark" aria-hidden="true">✳</span></span>
    </div>

    <div class="studio-window" :style="spotlightStyle" @pointermove="trackPointer" @pointerleave="resetPointer">
      <div class="studio-window-bar">
        <div class="studio-window-controls" aria-hidden="true"><i></i><i></i><i></i></div>
        <span class="studio-window-title">zanda.studio <span>/</span> workspace</span>
        <span class="studio-window-version">VOL. 01</span>
      </div>
      <div class="studio-workspace">
        <aside class="studio-sidebar" aria-label="Digital studio rooms">
          <p class="studio-sidebar-label">CHOOSE A ROOM</p>
          <button
            v-for="(room, index) in rooms"
            :key="room.id"
            type="button"
            class="studio-room-button"
            :class="{ 'is-active': activeRoomId === room.id }"
            :aria-pressed="activeRoomId === room.id"
            @click="activeRoomId = room.id"
          >
            <span class="studio-room-symbol" aria-hidden="true">{{ room.symbol }}</span>
            <span>{{ room.label }}</span>
            <span class="studio-room-arrow" aria-hidden="true">{{ activeRoomId === room.id ? '✳' : '↗' }}</span>
          </button>
          <div class="studio-sidebar-note"><span aria-hidden="true">♡</span><p>Made with curiosity, care and a little caffeine.</p></div>
        </aside>

        <div class="studio-room-content" :key="activeRoom.id">
          <div class="studio-room-topline">
            <span>{{ activeRoom.eyebrow }}</span>
            <span>0{{ rooms.findIndex((room) => room.id === activeRoom.id) + 1 }} <i aria-hidden="true">/</i> 04</span>
          </div>
          <h3>{{ activeRoom.title }}</h3>
          <p class="studio-room-description">{{ activeRoom.description }}</p>

          <div v-if="activeRoom.id === 'projects'" class="studio-collection studio-project-collection">
            <a class="studio-collection-card studio-card-weconnect" href="#project-01" @pointermove="tiltCard" @pointerleave="resetCard">
              <span class="studio-card-index">01 / FULL-STACK</span>
              <span class="studio-card-art" aria-hidden="true"><b>W</b><i>↗</i></span>
              <strong>WeConnect</strong><small>Vue.js · Express · MySQL</small>
              <span class="studio-card-link">Explore case study <i aria-hidden="true">↗</i></span>
            </a>
            <a class="studio-collection-card studio-card-moderntech" href="#project-02" @pointermove="tiltCard" @pointerleave="resetCard">
              <span class="studio-card-index">02 / HR TECHNOLOGY</span>
              <span class="studio-card-art" aria-hidden="true"><b>M</b><i>↗</i></span>
              <strong>Modern Tech</strong><small>JavaScript · Node.js · MySQL</small>
              <span class="studio-card-link">Explore case study <i aria-hidden="true">↗</i></span>
            </a>
            <a class="studio-collection-card studio-card-lightning" href="#project-03" @pointermove="tiltCard" @pointerleave="resetCard">
              <span class="studio-card-index">03 / DATA & SCRAPING</span>
              <span class="studio-card-art" aria-hidden="true"><b>L</b><i>↗</i></span>
              <strong>Lightning News</strong><small>Python · Flask · BeautifulSoup</small>
              <span class="studio-card-link">Explore case study <i aria-hidden="true">↗</i></span>
            </a>
          </div>

          <div v-else-if="activeRoom.id === 'credentials'" class="studio-collection studio-milestone-collection">
            <a class="studio-feature-card" href="https://www.credly.com/badges/f0b44bf4-8edf-4190-8070-e1c7e6486a22/public_url" target="_blank" rel="noopener noreferrer">
              <span class="studio-credential-mark" aria-hidden="true">✳</span>
              <span class="studio-feature-copy"><span class="studio-card-index">CISCO · CYBERSECURITY</span><strong>Introduction to Cybersecurity</strong><small>Passwords, encryption, firewalls, privacy and ethics.</small><b>View public badge ↗</b></span>
            </a>
            <a class="studio-journey-link" href="#achievements"><span>01</span><span><strong>Proof of progress</strong><small>Credentials and learning milestones</small></span><b aria-hidden="true">↗</b></a>
            <a class="studio-journey-link" href="#journey"><span>02</span><span><strong>My developer journey</strong><small>Life Choices Coding Academy → LC Studio</small></span><b aria-hidden="true">↗</b></a>
          </div>

          <div v-else-if="activeRoom.id === 'toolkit'" class="studio-collection studio-tool-collection">
            <div class="studio-tool-orbit" aria-label="Technologies used in my projects">
              <span class="studio-orbit-ring studio-orbit-ring-one"></span><span class="studio-orbit-ring studio-orbit-ring-two"></span>
              <span class="studio-orbit-core">MY<br />TOOLKIT</span>
              <span class="studio-orbit-chip studio-chip-vue">Vue.js</span><span class="studio-orbit-chip studio-chip-js">JavaScript</span>
              <span class="studio-orbit-chip studio-chip-node">Node / Express</span><span class="studio-orbit-chip studio-chip-sql">MySQL</span>
              <span class="studio-orbit-chip studio-chip-python">Python / Flask</span><span class="studio-orbit-chip studio-chip-git">Git / GitHub</span>
            </div>
            <a class="studio-room-cta" href="#skills">Explore skills and project evidence <span aria-hidden="true">↗</span></a>
          </div>

          <div v-else class="studio-collection studio-journal-collection">
            <a class="studio-journal-card" href="#blog"><span class="studio-journal-stamp">FIELD NOTE 01</span><strong>Trust the process.</strong><p>Read the error. Follow the clues. Test one change at a time.</p><span>Open the field journal ↗</span></a>
            <a class="studio-journal-card studio-journal-card-alt" href="#blog"><span class="studio-journal-stamp">FIELD NOTE 02</span><strong>Build beyond the interface.</strong><p>A feature is more than the screen — follow the data.</p><span>Open the field journal ↗</span></a>
          </div>

          <div class="studio-room-footer"><span aria-hidden="true">✳</span><span>ROOM SELECTED</span><span class="studio-footer-line"></span><span>KEEP EXPLORING</span></div>
        </div>
      </div>
    </div>
    <p class="studio-footnote"><span>Every good build starts with curiosity.</span><a href="#contact">Let’s make something meaningful <b aria-hidden="true">↗</b></a></p>
  </section>
</template>
