<script setup>
import { onMounted, onBeforeUnmount, ref } from 'vue'

const cursor = ref(null)
let frame = 0
let x = -100
let y = -100
let targetX = -100
let targetY = -100
let visible = false
let hovering = false

function onMove(event) {
  targetX = event.clientX
  targetY = event.clientY
  visible = true
  if (cursor.value) cursor.value.classList.add('is-visible')
  if (!frame) frame = requestAnimationFrame(animate)
}
function animate() {
  x += (targetX - x) * 0.28
  y += (targetY - y) * 0.28
  if (cursor.value) cursor.value.style.transform = `translate3d(${x - 9}px, ${y - 9}px, 0)`
  if (Math.abs(targetX - x) > 0.3 || Math.abs(targetY - y) > 0.3) {
    frame = requestAnimationFrame(animate)
  } else {
    frame = 0
  }
}
function onOver(event) {
  hovering = Boolean(event.target.closest('a, button, input, textarea, select, [role="button"]'))
  cursor.value?.classList.toggle('is-hovering', hovering)
}
function onLeave() {
  visible = false
  cursor.value?.classList.remove('is-visible')
}
onMounted(() => {
  if (window.matchMedia('(hover: hover) and (pointer: fine) and (prefers-reduced-motion: no-preference)').matches) {
    window.addEventListener('pointermove', onMove, { passive: true })
    document.addEventListener('pointerover', onOver, { passive: true })
    document.addEventListener('pointerleave', onLeave)
  }
})
onBeforeUnmount(() => {
  window.removeEventListener('pointermove', onMove)
  document.removeEventListener('pointerover', onOver)
  document.removeEventListener('pointerleave', onLeave)
  if (frame) cancelAnimationFrame(frame)
})
</script>

<template>
  <div ref="cursor" class="site-cursor-glow" aria-hidden="true"></div>
</template>
