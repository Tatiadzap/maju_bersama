<script lang="ts">
  // Import Libraries
  import dayjs from 'dayjs'
  import { Link } from '@inertiajs/svelte';
  import { Card } from '$lib/components/ui/card'
  import * as Avatar from "$lib/components/ui/avatar";
  import { Separator } from "$lib/components/ui/separator";

  // Component Props
  export let candidate
  export let user
  export let experiences
  export let educations

  // Utility functions
  function formatDate(date, format) {
    return dayjs(date).isValid() ? dayjs(date).format(format) : 'Invalid date';
  }
</script>

<Card class="p-6 mb-4 border-none shadow-none">
  <div class="flex justify-between">
    <Avatar.Root>
      <Avatar.Image src="https://github.com/shadcn.png" alt="@shadcn"/>
      <Avatar.Fallback>{candidate.first_name}</Avatar.Fallback>
    </Avatar.Root>
    <Link href="{candidate.id}/edit">Edit profile</Link>
  </div>
  <div>
    <h2 class="mb-4 text-lg font-bold">{candidate.first_name} {candidate.last_name}</h2>
    <p class="font-light">{user.email}</p>
    <p class="font-light">{user.phone}</p>
    <p class="font-light">{user.city}, {user.state}</p>
  </div>
</Card>

<Card class="p-6 mb-4 border-none shadow-none">
  <div>
    <h1 class="mb-4 text-lg font-bold">Bio</h1>
    <p class="">{user.bio}</p>
  </div>
</Card>

<Card class="p-6 mb-4 border-none shadow-none">
  <h1 class="text-lg font-bold">Experience</h1>
  {#each experiences as experience, index}
    <div class="py-12 space-y-1">
      <p class="text-lg font-medium">{experience.job_title}</p>
      <p class="">{experience.company_name}</p>
      <p class="text-sm text-gray-500">{formatDate(experience.start_date, 'MMM YYYY')} - {formatDate(experience.end_date, 'MMM YYYY')}</p>
      <p class="text-sm">{experience.description}</p>
    </div>
    {#if index < experiences.length - 1}
      <Separator />
    {/if}
  {/each}
</Card>

<Card class="p-6 mb-4 border-none shadow-none">
  <h1 class="text-lg font-bold">Education</h1>
  {#each educations as education, index}
    <div class="py-12 space-y-1">
      <p class="text-lg font-medium">{education.institution_name}</p>
      <p class="text-base">{education.degree} in {education.field_of_study}</p>
      <p class="text-sm text-gray-500">
        {formatDate(education.start_date, 'MMM YYYY')} - {formatDate(education.end_date, 'MMM YYYY')}</p>
      <p class="text-sm">{education.description}</p>
    </div>
    {#if index < educations.length - 1}
      <Separator />
    {/if}
  {/each}
</Card>

<Card class="p-6 mb-4 border-none shadow-none">
  <h1 class="text-lg font-bold">Languages</h1>
  {#each candidate.languages as language, index}
    <div class="py-12 space-y-1">
      <p class="text-gray-500"> {language}</p>
    </div>
    {#if index < candidate.languages.length - 1}
      <Separator />
    {/if}
  {/each}
</Card>
