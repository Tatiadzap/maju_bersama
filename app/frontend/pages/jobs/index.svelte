<script lang="ts">
  import { page } from '@inertiajs/svelte';
  import { applyForJob } from '$lib/jobApplicationUtils';
  import { Button } from "$lib/components/ui/button/index.js";
  import * as Card from "$lib/components/ui/card/index.js";
  import * as Avatar from "$lib/components/ui/avatar";

  const { auth } = $page.props;
  export let current_user = auth.user;

  export let jobs;

  // Local state to track applied jobs
  let appliedJobs = {};

  // Initialize appliedJobs state based on the data from the server
  $: jobs.forEach(job => {
    appliedJobs[job.id] = job.applied_by_current_user;
  });

  async function handleApply(job) {
    const success = await applyForJob(job.id, job.title, job.employer.company_name);
    if (success) {
      appliedJobs = { ...appliedJobs, [job.id]: true };
    }
  }
</script>

<h1 class="mx-auto my-24 text-5xl text-center">Discover the <span class="text-red-500">Best Jobs</span></h1>

<div class="grid grid-cols-1 gap-4">
  {#each jobs as job}
    <Card.Root class="w-full max-w-full overflow-hidden rounded-lg shadow-lg">
        <!-- Avatar -->

        <!-- Card Header -->
        <div class="w-full">
          <Card.Header class="flex p-0 pt-6 mt-4">
            <div class="flex px-4 space-x-6">
              <Avatar.Root class="w-24 h-24">
                <Avatar.Image src={job.employer.user.profile_picture} alt="Employer Profile Picture" class="object-cover" />
                <Avatar.Fallback></Avatar.Fallback>
              </Avatar.Root>
              <div class="self-center">
                <Card.Title class="text-xl font-bold">{job.title}</Card.Title>
                <Card.Description class="text-sm">{job.location} . <span class="text-sm">{job.status}</span></Card.Description>
              </div>
            </div>
          </Card.Header>
          <!-- Card Footer -->
          <Card.Footer class="flex justify-end pb-4 border-gray-200">
            <Button href={`/jobs/${job.id}`} variant="outline" class="mr-2">More Details</Button>
            {#if current_user.role === 'candidate'}
              <Button
                class={`self-center ${appliedJobs[job.id] ? 'bg-green-600 text-white' : ''}`}
                on:click={() => handleApply(job)}
              >
                {appliedJobs[job.id] ? "Applied" : "Apply"}
              </Button>
            {:else if current_user.role === 'employer'}
              <Button href="/jobs/{job.id}/edit"> Edit Job </Button>
            {/if}
          </Card.Footer>
        </div>
    </Card.Root>
  {/each}
</div>
