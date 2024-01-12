using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class CreateEllipsoidMesh : MonoBehaviour
{
    [MenuItem("Editor/Create Ellipsoid Mesh")]
    static void Create()
    {
        Vector3[] vertices = new Vector3[]
        {
            new Vector3(-0.5f, -0.5f, 0),
            new Vector3(-0.5f,  0.5f, 0),
            new Vector3( 0.5f, -0.5f, 0),
            new Vector3( 0.5f,  0.5f, 0)
        };

        Vector3[] normals = new Vector3[]
        {
            new Vector3(-0.5f, -0.5f, -1),
            new Vector3(-0.5f,  0.5f,  1),
            new Vector3( 0.5f, -0.5f, -1),
            new Vector3( 0.5f,  0.5f,  1)
        };

        Vector4[] uvs = new Vector4[]
        {
            new Vector4(0, 0, 0, 0),
            new Vector4(0, 1, 0, 1),
            new Vector4(1, 0, 0, 0),
            new Vector4(1, 1, 0, 1)
        };

        int[] indices = new int[]
        {
            0, 1, 2,
            2, 1, 3
        };

        var mesh = new Mesh();
        mesh.SetVertices(vertices);
        mesh.SetNormals(normals);
        mesh.SetUVs(0, uvs);
        mesh.SetIndices(indices, MeshTopology.Triangles, 0);

        mesh.RecalculateBounds();

        AssetDatabase.CreateAsset(mesh, "Assets/ellipsoid.asset");
        AssetDatabase.SaveAssets();
    }
}
