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
            new Vector3(0, 0, 0),
            new Vector3(0, 0, 1),
            new Vector3(0, 0, 0),
            new Vector3(0, 0, 1)
        };

        Vector3[] normals = new Vector3[]
        {
            new Vector3(-0.5f, -0.5f, -1),
            new Vector3(-0.5f,  0.5f,  1),
            new Vector3( 0.5f, -0.5f, -1),
            new Vector3( 0.5f,  0.5f,  1)
        };

        Vector2[] uvs = new Vector2[]
        {
            new Vector2(0, 0),
            new Vector2(0, 1),
            new Vector2(1, 0),
            new Vector2(1, 1)
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
