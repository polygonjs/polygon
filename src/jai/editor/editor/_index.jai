#load "Editor.jai";
#load "EditorCommands.jai";
#load "EditorEvent.jai";
#load "EditorNodePosition.jai";
#load "EditorNodeSelection.jai";
#load "EditorNodesScene.jai";
#load "EditorOnTick.jai";
#load "EditorRender.jai";
#load "EditorResize.jai";


#if WASM { #load "targets/EditorWasm.jai"; }
else { #load "targets/EditorNative.jai"; }