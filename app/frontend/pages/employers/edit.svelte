<script lang="ts">
  import { cubicInOut } from "svelte/easing";
  import { crossfade } from "svelte/transition";
  import { Button } from "$lib/components/ui/button";
  import * as Card from "$lib/components/ui/card";
  import { Input } from "$lib/components/ui/input";
  import { Label } from "$lib/components/ui/label";
  import { Textarea } from "$lib/components/ui/textarea";
  import { useForm, page } from "@inertiajs/svelte";
  import { onMount } from "svelte";

  export let employer = null;
  export let user = null;

  let form = useForm({
    employer: {
      company_name: employer?.company_name || '',
      industry: employer?.industry || '',
      website: employer?.website || '',
      company_description: employer?.company_description || '',
    },
    user: {
      phone: user?.phone || '',
      address: user?.address || '',
      city: user?.city || '',
      state: user?.state || '',
      zip_code: user?.zip_code || '',
      country: user?.country || '',
    }
  });

  let currentStep = 0;
  const steps = [
    {
      href: '#company-info',
      title: 'Company Info',
      description: 'Update your company details.',
    },
    {
      href: '#contact-info',
      title: 'Contact Info',
      description: 'Update your contact details.',
    },
    {
      href: '#additional-info',
      title: 'Additional Info',
      description: 'Provide additional information about your company.',
    }
  ];

  // Update current step based on hash on mount
  onMount(() => {
    const hash = $page.url.hash;
    const index = steps.findIndex(step => step.href === hash);
    if (index !== -1) {
      currentStep = index;
    }
  });

  const [send, receive] = crossfade({
    duration: 250,
    easing: cubicInOut,
  });

  function handleStepChange(step: number) {
    currentStep = step;
  }

  function goToNextStep() {
    if (currentStep < steps.length - 1) {
      currentStep += 1;
    }
  }

  function goToPreviousStep() {
    if (currentStep > 0) {
      currentStep -= 1;
    }
  }

  function submit() {
    console.log('Submitting form');
    $form.put(`/employers/${employer.id}`);
  }

  // Reactive variables for title and description based on the current step
  $: cardTitle = steps[currentStep].title;
  $: cardDescription = steps[currentStep].description;
</script>

<form on:submit|preventDefault={submit}>
  <div class="flex">
    <!-- Sidebar for step navigation -->
    <nav class="w-1/4 pr-4 space-y-2 text-left">
      <ul>
        {#each steps as item, index}
          {@const isActive = currentStep === index}

          <li>
            <a
              href={item.href}
              class={`block w-full p-2 rounded-md ${isActive ? 'bg-black text-white' : 'text-black'}`}
              on:click={() => handleStepChange(index)}
            >
              {item.title}
            </a>
          </li>
        {/each}
      </ul>
    </nav>

    <!-- Main content area for the current step -->
    <div class="w-3/4 p-4">
      <Card.Root>
        <Card.Header>
          <Card.Title>{cardTitle}</Card.Title>
          <Card.Description>{cardDescription}</Card.Description>
        </Card.Header>
        <Card.Content>
          {#if employer && user}
            <div class="space-y-4">
              {#if currentStep === 0}
                <!-- Company Info Step -->
                <div>
                  <Label for="company_name">Company Name</Label>
                  <Input id="company_name" bind:value={$form.employer.company_name} placeholder="Company Name" />
                  {#if $form.errors['employer.company_name']}
                    <div class="text-sm text-red-500">{$form.errors['employer.company_name']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="industry">Industry</Label>
                  <Input id="industry" bind:value={$form.employer.industry} placeholder="Industry" />
                  {#if $form.errors['employer.industry']}
                    <div class="text-sm text-red-500">{$form.errors['employer.industry']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="website">Website</Label>
                  <Input id="website" bind:value={$form.employer.website} placeholder="Website" />
                  {#if $form.errors['employer.website']}
                    <div class="text-sm text-red-500">{$form.errors['employer.website']}</div>
                  {/if}
                </div>
              {:else if currentStep === 1}
                <!-- Contact Info Step -->
                <div>
                  <Label for="phone">Phone</Label>
                  <Input id="phone" bind:value={$form.user.phone} placeholder="Phone" />
                  {#if $form.errors['user.phone']}
                    <div class="text-sm text-red-500">{$form.errors['user.phone']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="address">Address</Label>
                  <Input id="address" bind:value={$form.user.address} placeholder="Address" />
                  {#if $form.errors['user.address']}
                    <div class="text-sm text-red-500">{$form.errors['user.address']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="city">City</Label>
                  <Input id="city" bind:value={$form.user.city} placeholder="City" />
                  {#if $form.errors['user.city']}
                    <div class="text-sm text-red-500">{$form.errors['user.city']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="state">State</Label>
                  <Input id="state" bind:value={$form.user.state} placeholder="State" />
                  {#if $form.errors['user.state']}
                    <div class="text-sm text-red-500">{$form.errors['user.state']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="zip_code">Zip Code</Label>
                  <Input id="zip_code" bind:value={$form.user.zip_code} placeholder="Zip Code" />
                  {#if $form.errors['user.zip_code']}
                    <div class="text-sm text-red-500">{$form.errors['user.zip_code']}</div>
                  {/if}
                </div>

                <div>
                  <Label for="country">Country</Label>
                  <Input id="country" bind:value={$form.user.country} placeholder="Country" />
                  {#if $form.errors['user.country']}
                    <div class="text-sm text-red-500">{$form.errors['user.country']}</div>
                  {/if}
                </div>
              {:else if currentStep === 2}
                <!-- Additional Info Step -->
                <div class="grid gap-3">
                  <Label for="company_description">About</Label>
                  <Textarea
                    id="company_description"
                    bind:value={$form.employer.company_description}
                    placeholder="Tell us about your company"
                    class="min-h-32"
                  />
                  {#if $form.errors['employer.company_description']}
                    <div class="text-sm text-red-500">{$form.errors['employer.company_description']}</div>
                  {/if}
                </div>
              {/if}
            </div>
          {:else}
            <p>Loading...</p> <!-- Handle case where data is not yet available -->
          {/if}
        </Card.Content>

        <Card.Footer class="px-6 py-4">
          <div class="flex w-full justify-between">
            {#if currentStep > 0}
              <Button type="button" on:click={goToPreviousStep}>Previous</Button>
            {/if}
            {#if currentStep < steps.length - 1}
              <Button type="button" on:click={goToNextStep}>Next</Button>
            {/if}
          </div>
        </Card.Footer>
      </Card.Root>
      <div class="mt-4 mx-auto w-full">
        <Button class="w-full bg-green-600" type="submit" disabled={$form.processing}>Save</Button>
      </div>
    </div>
  </div>


</form>
