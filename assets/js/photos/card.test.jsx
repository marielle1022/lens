import React from 'react';
import { render } from '@testing-library/react';
import RTR from 'react-test-renderer';

import PhotoCard from './card';

test('photo card shows desc', () => {
  const photo  = { data: "about:blank", desc: "no photo" };
  const result = render(<PhotoCard photo={photo} />);
  expect(result.queryByText("no photo")).toBeTruthy();
});

test('render photo card snapshot', () => {
  const photo  = { data: "about:blank", desc: "no photo" };
  const result = RTR.create(<PhotoCard photo={photo} />);
  expect(result).toMatchSnapshot();
});

