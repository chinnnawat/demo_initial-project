import type { Preview } from '@storybook/react';
import React, { useEffect } from 'react';
import '../src/index.css'; // CSS ที่มี Tailwind + Preline styles

const withPreline = (Story: any) => {
  useEffect(() => {
  }, []);

  return <Story />;
};

const preview: Preview = {
  decorators: [withPreline],
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
  },
};

export default preview;
