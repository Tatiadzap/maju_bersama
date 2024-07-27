<script lang="ts">
  import { applyForJob } from '$lib/jobApplicationUtils';
  import { Button } from "$lib/components/ui/button";

  export let job;
  export let employer;
  export let company_details;

  // Local state to track if the job is applied
  export let isApplied
  console.log(isApplied)

  async function handleApply() {
    const success = await applyForJob(job.id, job.title, employer.company_name);
    if (success) {
      isApplied = true;
    }
  }
</script>

<div class="flex justify-between py-12">
  <div class="flex space-x-4">
    <img src={company_details.profile_picture} alt="Profile Picture" class="w-24 h-24">
    <div class="flex flex-col justify-center">
      <p class="text-xl font-medium">{job.title}</p>
      <div class="flex space-x-6">
        <p>{employer.company_name}</p>
        <p>{job.location}</p>
        <p>Full-time</p>
        <p>{job.status}</p>
      </div>
    </div>
  </div>

  <!-- Apply Button -->
  <Button
    class={`self-center ${isApplied ? 'bg-green-600 text-white' : 'bg-blue-500 text-black'}`}
    on:click={handleApply}
  >
    {isApplied ? "Applied" : "Apply"}
  </Button>
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
