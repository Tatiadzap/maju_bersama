<script lang="ts">
  import { page } from '@inertiajs/svelte';
  import { toast } from "svelte-sonner";
  import { registerForEvent } from '$lib/eventRegistrationUtils';

  import { Button } from "$lib/components/ui/button";
  import dayjs from 'dayjs';
  import { Link } from '@inertiajs/svelte';

  export let event;
  export let employer;
  export let company_details;

  export let isRegistered;
  const formattedStartDate = event.start_time ? dayjs(event.start_time).format('D MMMM YYYY, hh:mm A') : '';
  const formattedEndDate = event.end_time ? dayjs(event.end_time).format('D MMMM YYYY, hh:mm A') : '';

  console.log(event.start_time)

  // Define local state
  const { auth } = $page.props;
  export let current_user = auth.user;

  // Handle application (for similar functionality if needed)
  async function handleRegister() {
    const success = await registerForEvent(event.id, event.name, employer.company_name);
    if (success) {
      isRegistered = true;
      toast.success('Application successful!');
    } else {
      toast.error('Application failed. Please try again.');
    }
  }
</script>

<div class="flex justify-between py-12">
  <div class="flex space-x-4">
    <img src={company_details.profile_picture} alt="Company Logo" class="w-24 h-24">
    <div class="flex flex-col justify-center">
      <p class="text-xl font-medium">{event.name}</p>
      <div class="flex space-x-6">
        <p>{employer.company_name}</p>
        <p>{event.location}</p>
        <p>{formattedStartDate}</p>
      </div>
    </div>
  </div>

  <!-- Action Buttons -->
  {#if current_user.role === 'candidate'}
    <Button
      class={`self-center ${isRegistered ? 'bg-green-600 text-white' : 'bg-blue-500 text-black'}`}
      on:click={handleRegister}
    >
      {isRegistered ? "Registered" : "Register"}
    </Button>
  {:else if current_user.role === 'employer'}
    <Button href={`/events/${event.id}/edit`} class="bg-blue-500 text-white">Edit Event</Button>
  {/if}
</div>

<div class="w-full h-0.5 bg-gray-200"></div>

<div class="flex my-12">
  <div class="space-y-12 flex-basis-2/3">
    <div>
      <h2 class="mb-2 text-lg font-medium">Description</h2>
      <p>{event.description}</p>
    </div>

    <div class="space-y-2">
      <h2 class="mb-2 text-lg font-medium">Details</h2>
      <p>Location: {event.location}</p>
      <p>Start: {formattedStartDate} </p>
      <p>End: {formattedEndDate}</p>

    </div>
  </div>
</div>
