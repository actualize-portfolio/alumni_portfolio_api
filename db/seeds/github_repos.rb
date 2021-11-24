# frozen_string_literal: true

GithubRepo.create!(
  [
    { organization: 'vuejs', project: 'vue', category: :javascript_framework },
    { organization: 'facebook', project: 'react', category: :javascript_framework },
    { organization: 'angular', project: 'angular.js', category: :javascript_framework },
    { organization: 'sveltejs', project: 'svelte', category: :javascript_framework },
    { organization: 'emberjs', project: 'ember.js', category: :javascript_framework },
    { organization: 'rails', project: 'rails', category: :fullstack_framework },
    { organization: 'phoenixframework', project: 'phoenix', category: :fullstack_framework },
    { organization: 'django', project: 'django', category: :fullstack_framework },
    { organization: 'nuxt', project: 'nuxt.js', category: :fullstack_framework },
    { organization: 'ruby', project: 'ruby', category: :language },
    { organization: 'python', project: 'cpython', category: :language },
    { organization: 'rust-lang', project: 'rust', category: :language },
    { organization: 'elixir-lang', project: 'elixir', category: :language },
    { organization: 'scala', project: 'scala', category: :language },
    { organization: 'google', project: 'go-github', category: :language }
  ]
)
