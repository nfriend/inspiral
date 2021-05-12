interface VersionIndicatorProps {
  version: string;
}

export default function VersionIndicator(props: VersionIndicatorProps) {
  return (
    <span className="version-indicator">
      <span className="hidden sm:inline">
        Introduced in version {props.version}
      </span>
      <span className="sm:hidden">v{props.version}</span>
    </span>
  );
}
