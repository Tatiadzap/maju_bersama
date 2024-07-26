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


  // Local Data
  let projects = [
    {
      title: 'Project Alpha',
      description: 'A groundbreaking project in AI.',
      completion_date: '2024-06-15'
    },
    {
      title: 'Project Beta',
      description: 'An innovative web development project.',
      completion_date: '2024-07-20'
    }
  ];

  // Utility functions
  function formatDate(date, format) {
    return dayjs(date).isValid() ? dayjs(date).format(format) : 'Invalid date';
  }
</script>

<Card class="p-4 mb-4 rounded-none shadow-none bg-card text-card-foreground">
  <div>
    <Avatar.Root>
      <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn" class="h-[100px]"/>
      <Avatar.Fallback>{candidate.first_name}</Avatar.Fallback>
    </Avatar.Root>
  </div>
  <div>
    <h1 class="mb-4 text-2xl font-bold">{candidate.first_name} {candidate.last_name}</h1>
    <h2 class="font-light">{user.email}</h2>
    <h2 class="font-light">{user.phone}</h2>
    <h2 class="font-light">{user.city}, {user.state}</h2>
  </div>
</Card>

<Card class="p-4 mb-4 rounded-none shadow-none bg-card text-card-foreground">
  <div>
    <h1 class="mb-4 text-2xl font-bold">Bio</h1>
    <h2 class="font-light">{user.bio}</h2>
  </div>
</Card>

<Card class="p-4 mb-4 rounded-none shadow-none bg-card text-card-foreground">
  <h1 class="mb-1 text-2xl font-bold">Experience</h1>
  {#each experiences as experience}
    <div class="space-y-1">
      <h2 class="text-xl font-semibold">{experience.company_name}</h2>
      <p class="text-lg">{experience.job_title}</p>
      <p class="text-sm text-gray-500">{formatDate(experience.start_date, 'MMM YYYY')} - {formatDate(experience.end_date, 'MMM YYYY')}</p>
      <p class="text-base">{experience.description}</p>
    </div>
  {/each}
</Card>


<Card class="p-4 mb-4 rounded-none shadow-none bg-card text-card-foreground">
  <h1 class="mb-1 text-2xl font-bold">Education</h1>
  {#each educations as education}
    <div class="space-y-1">
      <p class="text-xl font-semibold">{education.institution_name}</p>
      <p class="text-lg">{education.degree} in {education.field_of_study}</p>
      <p class="text-sm text-gray-500">
        {formatDate(education.start_date, 'MMM YYYY')} - {formatDate(education.end_date, 'MMM YYYY')}</p>
      <p class="text-base">{education.description}</p>
    </div>
  {/each}

</Card>
