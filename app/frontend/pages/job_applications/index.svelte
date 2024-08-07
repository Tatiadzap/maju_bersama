<script lang="ts">
  import { page } from '@inertiajs/svelte';
  import { Button } from "$lib/components/ui/button/index.js";
  import * as Card from "$lib/components/ui/card/index.js";
  import * as Avatar from "$lib/components/ui/avatar";

  // Access user information from Inertia
  const { auth } = $page.props;
  export let current_user = auth.user;

  // The list of job applications with job details
  export let job_applications;
</script>

<h1 class="mx-auto my-24 text-5xl text-center">My <span class="text-red-500">Job Applications</span></h1>

<div class="grid grid-cols-1 gap-4">
  {#each job_applications as application}
    <Card.Root class="w-full max-w-full overflow-hidden rounded-lg shadow-lg">
        <!-- Avatar -->

        <!-- Card Header -->
        <div class="w-full">
          <Card.Header class="flex p-0 pt-6 mt-4">
            <div class="flex px-4 space-x-6">
              <Avatar.Root class="w-24 h-24">
                <Avatar.Image src={application.employer.user.profile_picture} alt="Employer Profile Picture" class="object-cover" />
                <Avatar.Fallback></Avatar.Fallback>
              </Avatar.Root>
              <div class="self-center">
                <Card.Title class="text-xl font-bold">{application.title}</Card.Title>
                <Card.Description class="text-sm">{application.location} . <span class="text-sm">{application.status}</span></Card.Description>
              </div>
            </div>
          </Card.Header>
          <!-- Card Footer -->
          <Card.Footer class="flex justify-end pb-4 border-gray-200">
            <Button href={`/jobs/${application.id}`} variant="outline" class="mr-2">More Details</Button>
            {#if current_user.role === 'candidate'}
              <div class="self-center font-bold text-green-600">
                Applied on {new Date(application.created_at).toLocaleDateString()}
              </div>
            {/if}
          </Card.Footer>
        </div>
    </Card.Root>
  {/each}
</div>
