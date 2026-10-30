<script setup>
import { ref } from 'vue'

const props = defineProps({
  project: { type: Object, required: true },
  selectedSkill: { type: String, default: '' },
  individualContributions: { type: Object, required: true },
})

const caseStudyDialog = ref(null)
let lastFocusedElement = null
function openCaseStudy(event) {
  lastFocusedElement = event?.currentTarget || document.activeElement
  caseStudyDialog.value?.showModal()
}
function closeCaseStudy() {
  caseStudyDialog.value?.close()
  requestAnimationFrame(() => lastFocusedElement?.focus?.())
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
function contributionGroups(projectName) {
  const contributions = props.individualContributions?.[projectName] || []
  const groups = [
    { title: 'INTERFACE & EXPERIENCE', terms: ['vue', 'frontend', 'navigation', 'styling', 'pages', 'components', 'dashboard'] },
    { title: 'BACKEND & DATA', terms: ['express', 'api', 'mysql', 'database', 'aiven', 'python', 'flask', 'beautifulsoup', 'parsing', 'data extraction'] },
    { title: 'DELIVERY & COLLABORATION', terms: ['testing', 'debugging', 'git', 'collaboration', 'deployment'] },
  ]
  const categorized = groups.map((group) => ({
    title: group.title,
    items: contributions.filter((item) => group.terms.some((term) => item.toLowerCase().includes(term))),
  })).filter((group) => group.items.length)
  const assigned = new Set(categorized.flatMap((group) => group.items))
  const remaining = contributions.filter((item) => !assigned.has(item))
  if (remaining.length) categorized.push({ title: 'OTHER CONTRIBUTIONS', items: remaining })
  return categorized
}
</script>

<template>
            <article @pointermove="tiltCard" @pointerleave="resetTilt" :id="'project-' + project.number" class="project-card" :class="{ 'project-muted': selectedSkill && !project.tags.some(tag => selectedSkill.toLowerCase().includes(tag.toLowerCase()) || tag.toLowerCase().includes(selectedSkill.toLowerCase()) || project.description.toLowerCase().includes(selectedSkill.toLowerCase())) }">
              <div class="project-art" :class="project.theme">
                <span class="art-label">{{ project.number }} / CASE STUDY</span>
                <span class="art-star">✳</span>
                <img
                  v-if="project.name === 'Modern Tech'"
                  class="project-screenshot"
                  src="/Screenshot%202026-07-05%20193803.png"
                  alt="Screenshot of the Modern Tech HR management project"
                  loading="lazy"
                  decoding="async"
                />
                <iframe
                  v-else-if="project.name === 'WeConnect' && project.demoUrl"
                  class="project-live-demo"
                  :src="project.demoUrl"
                  sandbox="allow-scripts allow-forms allow-same-origin"
                  :title="'Live preview of ' + project.name"
                  loading="lazy"
                  referrerpolicy="strict-origin-when-cross-origin"
                  allow="clipboard-read; clipboard-write"
                ></iframe>
                <img
                  v-else-if="project.name === 'Lightning News'"
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
                <a
                  class="art-foot"
                  :href="project.demoUrl || project.repoUrl || project.url"
                  target="_blank"
                  rel="noopener noreferrer"
                >{{ project.demoUrl ? 'OPEN LIVE DEMO ↗' : 'VIEW REPOSITORY ↗' }}</a>
              </div>
              <p class="project-meta">{{ project.type }}</p>
              <span class="project-number">PROJECT {{ project.number }} <span aria-hidden="true">✳</span></span>
              <h3>{{ project.name }}</h3>
              <p class="project-description">{{ project.description }}</p>
              
              <div class="tag-list"><span v-for="tag in project.tags" :key="tag">{{ tag }}</span></div>

              <div class="project-actions">
                <button type="button" class="project-link project-case-study-trigger" aria-haspopup="dialog" @click="openCaseStudy">Case study <span aria-hidden="true">↗</span></button>
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
                  <section
                    v-if="project.name === 'Modern Tech'"
                    class="demo-credentials modern-tech-credentials"
                    aria-label="Modern Tech demo access"
                  >
                    <div class="demo-credentials-heading">
                      <span class="demo-access-label">LIVE WEBSITE &amp; DEMO ACCESS</span>
                      <span class="demo-live-indicator">Demo access</span>
                    </div>
                    <div class="demo-resource-links">
                      <a v-if="project.demoUrl" :href="project.demoUrl" target="_blank" rel="noopener noreferrer">Open live website ↗</a>
                    </div>
                    <p class="demo-credentials-note">For security, login credentials are not published on this portfolio. Please contact me if you need a demonstration account.</p>
                  </section>
                  <section
                    v-if="project.name === 'WeConnect'"
                    class="demo-credentials"
                    aria-label="WeConnect project links"
                  >
                    <div class="demo-credentials-heading">
                      <span class="demo-access-label">PROJECT LINKS</span>
                      <span class="demo-live-indicator">Explore the project</span>
                    </div>
                    <div class="demo-resource-links">
                      <a v-if="project.demoUrl" :href="project.demoUrl" target="_blank" rel="noopener noreferrer">Open main website ↗</a>
                      <a v-if="project.adminUrl" :href="project.adminUrl" target="_blank" rel="noopener noreferrer">Open admin portal ↗</a>
                      <a v-if="project.adminRepoUrl" :href="project.adminRepoUrl" target="_blank" rel="noopener noreferrer">Admin repository ↗</a>
                      <a v-if="project.designUrl" :href="project.designUrl" target="_blank" rel="noopener noreferrer">View Figma design ↗</a>
                    </div>
                    <p class="demo-credentials-note">Demo login details are intentionally not displayed publicly. Contact me if you need a guided demonstration.</p>
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
                  <div v-if="props.individualContributions?.[project.name]?.length" class="project-case-dialog-contributions">
                    <h4>MY CONTRIBUTIONS</h4>
                    <div class="contribution-groups">
                      <section v-for="group in contributionGroups(project.name)" :key="group.title" class="contribution-group">
                        <h5>{{ group.title }}</h5>
                        <ul><li v-for="contribution in group.items" :key="contribution">{{ contribution }}</li></ul>
                      </section>
                    </div>
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
