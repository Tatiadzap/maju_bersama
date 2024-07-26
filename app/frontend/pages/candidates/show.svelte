<script lang="ts">
  // Import Libraries
  import dayjs from 'dayjs'
  import { Link } from '@inertiajs/svelte';
  import { Card } from '$lib/components/ui/card'
  import * as Avatar from "$lib/components/ui/avatar";

  // Component Props
  export let candidate
  export let user
  export let experiences
  export let educations

  console.log(candidate.languages)

  // Utility functions
  function formatDate(date, format) {
    return dayjs(date).isValid() ? dayjs(date).format(format) : 'Invalid date';
  }
</script>

<Card class="p-6 mb-4 border-none shadow-none">
  <div class = "mb-4">
    <Avatar.Root>
      <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" class="h-[100px]"/>
      <Avatar.Fallback>{candidate.first_name}</Avatar.Fallback>
    </Avatar.Root>
  </div>
  <div>
    <h1 class="mb-4 text-lg font-bold">{candidate.first_name} {candidate.last_name}</h1>
    <h2 class="font-light">{user.email}</h2>
    <h2 class="font-light">{user.phone}</h2>
    <h2 class="font-light">{user.city}, {user.state}</h2>
  </div>
</Card>

<Card class="p-6 mb-4 bg-white border-none shadow-none">
  <div>
    <h1 class="mb-4 text-lg font-bold">Bio</h1>
    <h2 class="font-light">{user.bio}</h2>
  </div>
</Card>

<Card class="p-6 mb-4 border-none shadow-none">
  <h1 class="mb-4 text-lg font-bold">Experience</h1>
  {#each experiences as experience}
    <div class="mb-12 space-y-1">
      <p class="text-lg font-medium">{experience.job_title}</p>
      <h2 class="">{experience.company_name}</h2>
      <p class="text-sm text-gray-500">{formatDate(experience.start_date, 'MMM YYYY')} - {formatDate(experience.end_date, 'MMM YYYY')}</p>
      <p class="text-sm">{experience.description}</p>
    </div>
  {/each}
</Card>


<Card class="p-6 mb-4 border-none shadow-none">
  <h1 class="mb-4 text-lg font-bold">Education</h1>
  {#each educations as education}
    <div class="space-y-1">
      <p class="text-lg font-semibold">{education.institution_name}</p>
      <p class="text-base">{education.degree} in {education.field_of_study}</p>
      <p class="text-sm text-gray-500">
        {formatDate(education.start_date, 'MMM YYYY')} - {formatDate(education.end_date, 'MMM YYYY')}</p>
      <p class="text-sm">{education.description}</p>
    </div>
  {/each}
</Card>

<Card class="p-6 mb-4 border-none shadow-none">
  <h1 class="mb-4 text-lg font-bold">Languages</h1>
  {#each candidate.languages as language}
    <div class="space-y-1">
      <p class="text-gray-500"> {language}</p>
    </div>
  {/each}
</Card>
