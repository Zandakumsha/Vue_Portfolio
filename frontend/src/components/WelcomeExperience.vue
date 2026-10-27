<script setup>
import { computed, ref } from 'vue'

const emit = defineEmits(['complete'])
const name = ref('')
const hasGreeting = ref(false)
const safeName = computed(() => name.value.trim().replace(/\s+/g, ' ').slice(0, 40))
function submitName() {
  if (!safeName.value) return
  name.value = safeName.value
  hasGreeting.value = true
}
function enterPortfolio() {
  emit('complete', safeName.value)
}
function skipWelcome() {
  emit('complete', '')
}
</script>

<template>
  <div class="welcome-screen" role="dialog" aria-modal="true" aria-labelledby="welcome-title">
    <div class="welcome-grain" aria-hidden="true"></div>
    <div class="welcome-orbit welcome-orbit-one" aria-hidden="true"></div>
    <div class="welcome-orbit welcome-orbit-two" aria-hidden="true"></div>
    <div class="welcome-spark welcome-spark-one" aria-hidden="true">✳</div>
    <div class="welcome-spark welcome-spark-two" aria-hidden="true">✦</div>
    <div class="welcome-spark welcome-spark-three" aria-hidden="true">✧</div>

    <div class="welcome-content" :class="{ 'welcome-content-greeted': hasGreeting }">
      <p class="welcome-eyebrow"><span class="welcome-live-dot"></span> A PERSONAL PORTFOLIO BY ZANDA KUMSHA</p>
      <div class="welcome-monogram" aria-hidden="true"><span>Z</span><i>✳</i></div>

      <template v-if="!hasGreeting">
        <p class="welcome-overline">A little space for big ideas</p>
        <h1 id="welcome-title">Before you <em>step inside…</em></h1>
        <p class="welcome-description">Let’s make this visit feel a little more personal. What should I call you?</p>
        <form class="welcome-form" @submit.prevent="submitName">
          <label for="visitor-name">YOUR NAME OR NICKNAME</label>
          <div class="welcome-input-wrap">
            <input id="visitor-name" v-model="name" name="visitor-name" type="text" autocomplete="given-name" maxlength="40" placeholder="Type your name here…" required autofocus />
            <span aria-hidden="true">♡</span>
          </div>
          <button class="welcome-submit" type="submit">Make yourself at home <span aria-hidden="true">↗</span></button>
        </form>
        <button class="welcome-skip" type="button" @click="skipWelcome">I’d rather explore without a name <span aria-hidden="true">→</span></button>
      </template>

      <template v-else>
        <p class="welcome-overline welcome-overline-greeting">YOUR SPACE IS READY</p>
        <h1 id="welcome-title" class="welcome-personal-title">Welcome in,<br /><em>{{ safeName }}.</em></h1>
        <p class="welcome-description">I’m so glad you’re here. Take a look around, explore what I’ve been building, and stay curious.</p>
        <button class="welcome-submit welcome-enter" type="button" @click="enterPortfolio">Let’s explore <span aria-hidden="true">↗</span></button>
        <p class="welcome-signoff">Thoughtful design. Curious by nature. Driven to build.</p>
      </template>
    </div>
    <div class="welcome-bottom-line"><span>DESIGNED WITH CARE</span><span>✳</span><span>BUILT WITH CURIOSITY</span></div>
  </div>
</template>
