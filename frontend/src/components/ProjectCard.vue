<script setup>
defineProps({
  project: { type: Object, required: true },
  selectedSkill: { type: String, default: '' },
  individualContributions: { type: Object, required: true },
})
</script>

<template>
            <article :id="'project-' + project.number" class="project-card" :class="{ 'project-muted': selectedSkill && !project.tags.some(tag => selectedSkill.toLowerCase().includes(tag.toLowerCase()) || tag.toLowerCase().includes(selectedSkill.toLowerCase()) || project.description.toLowerCase().includes(selectedSkill.toLowerCase())) }">
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
                <a class="project-link" :href="project.repoUrl || project.url" target="_blank" rel="noreferrer">View code <span aria-hidden="true">↗</span></a>
                <a v-if="project.demoUrl" class="project-link project-demo-link" :href="project.demoUrl" target="_blank" rel="noreferrer">Live demo <span aria-hidden="true">↗</span></a>
              </div>
              <details class="case-study">
                <summary>Case study & contributions <span class="case-study-toggle" aria-hidden="true">＋</span></summary>
                <div class="case-study-content">
                  <p><strong>Project focus</strong>{{ project.focus }}</p>
                  <p><strong>The challenge</strong>{{ project.challenge }}</p>
                  <p><strong>Technical approach</strong>{{ project.approach }}</p>
                  <p><strong>What it taught me</strong>{{ project.learning }}</p>
                  <div v-if="individualContributions[project.name]" class="contribution-note">
                    <strong>My contributions</strong>
                    <ul>
                      <li v-for="contribution in individualContributions[project.name]" :key="contribution">{{ contribution }}</li>
                    </ul>
                    <p class="team-context">These are my confirmed contributions within a wider team project; the overall project description covers the team deliverable.</p>
                  </div>
                  <p v-else-if="project.contributionNote" class="contribution-note">{{ project.contributionNote }}</p>
                </div>
              </details>
            </article>
</template>
