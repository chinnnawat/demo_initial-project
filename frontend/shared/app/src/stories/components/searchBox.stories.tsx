import SearchBox from "./searchBox";

export default {
    title: "Components/Sidebar",
    component: SearchBox,
    parameters: {
        layout: "fullscreen",
    },
};

export const _Sidebar = {
    args: {
        children: <SearchBox />,
    },
};
