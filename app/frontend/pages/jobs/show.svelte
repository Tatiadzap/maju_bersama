<script lang="ts">
  import { page } from '@inertiajs/svelte';
  import { applyForJob, unapplyForJob } from '$lib/jobApplicationUtils';
  import { Button } from "$lib/components/ui/button";

  export let job;
  export let employer = job?.employer || {};
  export let company_details = job?.company_details || {};

  console.log(employer)

  let isApplied = job.applied_by_current_user;

  async function handleApply() {
    if (isApplied) {
      const success = await unapplyForJob(job.id, job.title, employer.company_name);
      if (success) {
        isApplied = false;
      }
    } else {
      const success = await applyForJob(job.id, job.title, employer.company_name);
      if (success) {
        isApplied = true;
      }
    }
  }

  const { auth } = $page.props;
  export let current_user = auth.user;
</script>

<div class="flex justify-between py-12">
  <div class="flex space-x-4">
    <img src={company_details.profile_picture} alt="company_logo" class="w-24 h-24">
    <div class="flex flex-col justify-center">
      <p class="text-xl font-medium">{job.title}</p>
      <div class="flex space-x-6">
        <!-- <p>{employer.company_name}</p> -->
        <p>{job.location}</p>
        <p>Full-time</p>
        <p>{job.status}</p>
      </div>
    </div>
  </div>

  {#if current_user.role === 'candidate'}
    <Button
      class={`self-center ${isApplied ? 'bg-green-600 text-white' : 'bg-blue-500 text-black'}`}
      on:click={handleApply}
    >
      {isApplied ? "Applied" : "Apply"}
    </Button>
  {:else if current_user.role === 'employer'}
    <Button href={`/jobs/${job.id}/edit`} class="bg-blue-500 text-white"> Edit Job </Button>
  {/if}
</div>

<div class="w-full h-0.5 bg-gray-200"></div>

<div class="flex my-12">
  <div class="space-y-12 flex-basis-2/3">
    <div>
      <h2 class="mb-2 text-lg font-medium">About the role</h2>
      <p>{job.description}</p>
    </div>

    <div>
      <h2 class="mb-2 text-lg font-medium">Job requirements</h2>
      <p>{job.requirements}</p>
    </div>
  </div>
</div>
