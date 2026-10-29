<script setup>
import { ref } from 'vue'

defineProps({
  project: { type: Object, required: true },
  selectedSkill: { type: String, default: '' },
  individualContributions: { type: Object, required: true },
})

const caseStudyDialog = ref(null)
function openCaseStudy() {
  caseStudyDialog.value?.showModal()
}
function closeCaseStudy() {
  caseStudyDialog.value?.close()
}
function tiltCard(event) {
  if (event.pointerType === 'touch' || window.matchMedia('(prefers-reduced-motion: reduce)').matches) return
  const card = event.currentTarget
  const rect = card.getBoundingClientRect()
  const x = (event.clientX - rect.left) / rect.width - 0.5
  const y = (event.clientY - rect.top) / rect.height - 0.5
  card.style.setProperty('--project-ry', `${x * 5}deg`)
  card.style.setProperty('--project-rx', `${-y * 5}deg`)
}
function resetTilt(event) {
  event.currentTarget.style.setProperty('--project-rx', '0deg')
  event.currentTarget.style.setProperty('--project-ry', '0deg')
}
</script>

<template>
            <article @pointermove="tiltCard" @pointerleave="resetTilt" :id="'project-' + project.number" class="project-card" :class="{ 'project-muted': selectedSkill && !project.tags.some(tag => selectedSkill.toLowerCase().includes(tag.toLowerCase()) || tag.toLowerCase().includes(selectedSkill.toLowerCase()) || project.description.toLowerCase().includes(selectedSkill.toLowerCase())) }">
              <a class="project-art" :class="project.theme" :href="project.demoUrl || project.repoUrl || project.url" target="_blank" rel="noreferrer" :aria-label="'Open ' + project.name">
                <span class="art-label">{{ project.number }} / CASE STUDY</span>
                <span class="art-star">✳</span>
                <img
                  v-if="project.name === 'Lightning News'"
                  class="project-screenshot"
                  src="https://i.ibb.co/bj7C9TgS/Screenshot-2026-10-11-015612.png"
                  alt="Screenshot of the Lightning News analytics dashboard"
                  loading="lazy"
                  decoding="async"
                />
                <div v-else class="mock-window">
                  <div class="window-bar"><i></i><i></i><i></i><small>studio / {{ project.initials.toLowerCase() }}</small></div>
                  <div class="window-content"><b>{{ project.initials }}</b><span class="mock-lines"><i></i><i></i><i></i></span><span class="mock-arrow">↗</span></div>
                </div>
                <span class="art-foot">{{ project.demoUrl ? 'VIEW LIVE DEMO ↗' : 'VIEW REPOSITORY ↗' }}</span>
              </a>
              <p class="project-meta">{{ project.type }}</p>
              <span class="project-number">PROJECT {{ project.number }} <span aria-hidden="true">✳</span></span>
              <h3>{{ project.name }}</h3>
              <p class="project-description">{{ project.description }}</p>
              
              <div class="tag-list"><span v-for="tag in project.tags" :key="tag">{{ tag }}</span></div>

              <div class="project-actions">
                <button type="button" class="project-link project-case-study-trigger" @click="openCaseStudy">Case study <span aria-hidden="true">↗</span></button>
                <a class="project-link" :href="project.repoUrl || project.url" target="_blank" rel="noopener noreferrer">View code <span aria-hidden="true">↗</span></a>
                <a v-if="project.demoUrl" class="project-link project-demo-link" :href="project.demoUrl" target="_blank" rel="noopener noreferrer">Live demo <span aria-hidden="true">↗</span></a>
              </div>
              <dialog ref="caseStudyDialog" class="project-case-dialog" :aria-labelledby="'case-study-title-' + project.number" @click.self="closeCaseStudy">
                <div class="project-case-dialog-inner">
                  <button type="button" class="project-case-dialog-close" aria-label="Close case study" @click="closeCaseStudy">×</button>
                  <span class="project-meta">{{ project.type }}</span>
                  <h3 :id="'case-study-title-' + project.number">{{ project.name }}</h3>
                  <p class="project-case-dialog-intro">{{ project.focus }}</p>
                  <h4>PROJECT SNAPSHOT</h4>
                  <div class="project-case-facts">
                    <div><span>PROJECT TYPE</span><strong>{{ project.type }}</strong></div>
                    <div><span>TECHNOLOGIES</span><strong>{{ project.tags.join(' · ') }}</strong></div>
                    <div><span>PROJECT FOCUS</span><strong>{{ project.focus }}</strong></div>
                  </div>
                  <section v-if="project.demoAccounts?.length" class="demo-credentials" aria-label="WeConnect live website and public demo login details">
                    <div class="demo-credentials-heading">
                      <span class="demo-access-label">LIVE WEBSITE &amp; LOGIN DETAILS</span>
                      <span class="demo-live-indicator"><i aria-hidden="true"></i> Public demo</span>
                    </div>
                    <div class="demo-resource-links">
                      <a :href="project.demoUrl" target="_blank" rel="noopener noreferrer">Open main website <span aria-hidden="true">↗</span></a>
                      <a :href="project.adminUrl" target="_blank" rel="noopener noreferrer">Open admin portal <span aria-hidden="true">↗</span></a>
                      <a :href="project.adminRepoUrl" target="_blank" rel="noopener noreferrer">Admin repository <span aria-hidden="true">↗</span></a>
                      <a :href="project.designUrl" target="_blank" rel="noopener noreferrer">View Figma design <span aria-hidden="true">↗</span></a>
                    </div>
                    <p class="demo-credentials-note">Use either demo account below to explore the relevant WeConnect experience.</p>
                    <div class="demo-account-list">
                      <div v-for="account in project.demoAccounts" :key="account.role" class="demo-account">
                        <h4>{{ account.role }} account</h4>
                        <p><span>Email</span><code>{{ account.email }}</code></p>
                        <p><span>Password</span><code>{{ account.password }}</code></p>
                      </div>
                    </div>
                  </section>
                  <h4>THE CHALLENGE</h4><p>{{ project.challenge }}</p>
                  <h4>TECHNICAL APPROACH</h4><p>{{ project.approach }}</p>
                  <h4>ARCHITECTURE &amp; DATA FLOW</h4><p>{{ project.architecture || project.approach }}</p>
                  <h4>TESTING CHECKLIST</h4><p>{{ project.testingNotes || 'Test the primary user journeys, validation, error states, accessibility and responsive layouts before release.' }}</p>
                  <h4>KEY DESIGN DECISION</h4><p>{{ project.decisions || 'Keep responsibilities clear, validate data at the boundary, and make important states visible to the user.' }}</p>
                  <h4>WHAT I LEARNED</h4><p>{{ project.learning }}</p>
                  <h4>MY ROLE</h4><p>{{ project.role || 'Project contributor' }}</p>
                  <h4>FUTURE IMPROVEMENTS</h4><p>{{ project.nextSteps || 'Further improvements can be identified through testing and feedback.' }}</p>
                  <div v-if="project.contributions?.length" class="project-case-dialog-contributions">
                    <h4>DELIVERABLES &amp; RESPONSIBILITIES</h4>
                    <ul><li v-for="contribution in project.contributions" :key="contribution">{{ contribution }}</li></ul>
                  </div>
                  <div v-if="individualContributions[project.name]" class="project-case-dialog-contributions">
                    <h4>MY CONTRIBUTIONS</h4>
                    <ul><li v-for="contribution in individualContributions[project.name]" :key="contribution">{{ contribution }}</li></ul>
                  </div>
                  <p v-else-if="project.contributionNote">{{ project.contributionNote }}</p>
                  <div class="project-case-dialog-actions">
                    <a v-if="project.demoUrl" :href="project.demoUrl" target="_blank" rel="noopener noreferrer">Live demo ↗</a>
                    <a :href="project.repoUrl || project.url" target="_blank" rel="noopener noreferrer">Source code ↗</a>
                  </div>
                </div>
              </dialog>

            </article>
</template>
