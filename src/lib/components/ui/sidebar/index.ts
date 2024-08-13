// Import components
import SidebarMenu from "./SidebarMenu.svelte";
import SidebarItem from "./SidebarItem.svelte";

// Define types for the props used in SidebarMenu and SidebarItem
type SidebarItemProps = {
  href: string;
  title: string;
  isActive: boolean;
  onClick: () => void;
};

type SidebarMenuProps = {
  currentSection: string;
  onSectionChange: (section: string) => void;
  sections: Array<{ href: string; title: string }>;
};

// Export components and types
export {
  SidebarMenu,
  SidebarItem,
  type SidebarItemProps,
  type SidebarMenuProps,
};

// Default export for namespace import style
const Sidebar = {
  SidebarMenu,
  SidebarItem,
};

export default Sidebar;
