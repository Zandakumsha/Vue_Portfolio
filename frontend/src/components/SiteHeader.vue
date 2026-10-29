<script setup>
defineProps({ menuOpen: Boolean, themeDark: Boolean })
const emit = defineEmits(['update:menuOpen', 'toggle-theme'])
function closeMenu() { emit('update:menuOpen', false) }
</script>

<template>
  <header class="topbar">
    <a class="brand" href="#home" aria-label="Zanda home" @click="closeMenu">
      <span class="brand-mark">z.</span>
      <span class="brand-copy">ZANDA K.<small>DEVELOPER & CREATIVE THINKER</small></span>
    </a>
    <button
      class="menu-toggle"
      type="button"
      :aria-expanded="menuOpen"
      aria-controls="main-navigation"
      @click="$emit('update:menuOpen', !menuOpen)"
    >
      {{ menuOpen ? 'Close −' : 'Menu +' }}
    </button>
    <nav id="main-navigation" class="navigation" :class="{ 'navigation-open': menuOpen }" aria-label="Main navigation">
      <a href="#about" @click="closeMenu">About</a>
      <a href="#work" @click="closeMenu">Projects</a>
      <a href="#skills" @click="closeMenu">Expertise</a>
      <a href="#journey" @click="closeMenu">Journey</a>
      <a href="#blog" @click="closeMenu">Journal</a>
      <a href="#achievements" @click="closeMenu">Milestones</a>
      <a class="nav-contact" href="#contact" @click="closeMenu">Let's talk ↗</a>
    </nav>
    <button class="theme-toggle" type="button" :aria-pressed="themeDark" @click="emit('toggle-theme')">{{ themeDark ? 'Light mode ☼' : 'Dark mode ☾' }}</button>
  </header>
</template>
