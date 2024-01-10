using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rot : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    float t = 0.0f;

    // Update is called once per frame
    void Update()
    {
        t += Time.deltaTime;
        float x = Mathf.Cos(t);
        float y = Mathf.Sin(t);
        Vector3 v = new Vector3(x, y, 2.0f);
        //v.normalized;

        transform.rotation = Quaternion.LookRotation(v, Vector3.up);
    }
}
